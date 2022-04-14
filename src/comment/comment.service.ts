import { HttpException, HttpStatus, Inject, Injectable, InternalServerErrorException } from "@nestjs/common";
import { FileUpload } from "graphql-upload";
import { FileService } from "src/file/file.service";
import { PaginationArgs } from "src/post/dto/pagination.args";
import { User } from "src/user/user.entity";
import { FindManyOptions, FindOptionsOrder, FindOptionsUtils, FindOptionsWhere, Repository } from "typeorm";
import { Comment } from "./comment.entity";
import { CommentView } from "./comment.view.entity";
import { ChangeCommentInput } from "./dto/change.comment.input";
import { CommentArgs } from "./dto/comment.args";
import { CommentInput } from "./dto/comment.input";

@Injectable()
export class CommentService{
    constructor(
        @Inject(process.env.CommentRepo)
        private repo: Repository<Comment>,
        private fileSer: FileService,
        @Inject(process.env.CommentView)
        private repoView: Repository<CommentView>,
    ){}

    async findPostComments(postId: number,args: CommentArgs){
        let options: FindManyOptions<CommentView> = {}
        let optionsWhere: FindOptionsWhere<CommentView> = {
            postId:postId,
        }
        options.where = optionsWhere;
        options.skip = args.offset;
        options.take = args.first;
        if(args.sort){   
            let optionsOrder: FindOptionsOrder<CommentView> = {
                [args.sort.by]:args.sort.order, 
            };
            options.order = optionsOrder;
        }
        let comments: CommentView[]
        try{
            comments = await this.repoView.find(options)
        }catch(err){
            throw new InternalServerErrorException('Failed to load comments')
        }
        return comments;
    }

    async createComment(comment: CommentInput,user: User, files?:Promise<FileUpload>[]){
        let newComment: Comment
        const commentEntity = this.repo.create({text:comment.text,postId:comment.postId,authorId:user.id})
        try{
            newComment = await this.repo.save(commentEntity)
        }
        catch(err){
            throw new InternalServerErrorException('Cant comment')
        }
        if(files)await this.fileSer.addFiles(newComment,files)
        return newComment
    }

    async getAuthor(comment: Comment){
        let result: Comment;
        try{
            result = await this.repo.findOneOrFail({
                relations:{
                    author:true
                },
                select:{
                    author:{
                        id:true,
                        email:true,
                    }
                },
                where:{
                    id:comment.id
                }
            })
        } catch(err){
            throw new InternalServerErrorException('Cant find author')
        }
        return result.author
    }

    async getComment(commentId:number){
        let comment: CommentView;
        try{
            comment = await this.repoView.findOneByOrFail({id:commentId})
        }catch(err){
            throw new InternalServerErrorException('Cant load comment')
        }
        return comment;
    }

    async changeComment(changes: ChangeCommentInput,comment: Comment,deleteKeys?:string[],addFiles?:Promise<FileUpload>[]){
        Object.assign(comment,changes)
        try{
           await this.repo.save(comment)
        }catch(err){
            throw new InternalServerErrorException('Failed to edit comment')
        }
        if(addFiles){
            await this.fileSer.addFiles(comment,changes.addFiles)
        }
        if(deleteKeys){
            await this.fileSer.deleteFiles(comment,deleteKeys)
        }
        return await this.getComment(comment.id)
    }

    async deleteComment(comment: Comment){
        await this.fileSer.deleteFiles(comment)
        try{ 
            await this.repo.remove(comment)
        }catch(err){
            throw new InternalServerErrorException(`Cant delete comment ${comment.text}`)
        }
        return comment;
    }
}