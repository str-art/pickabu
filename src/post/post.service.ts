import { Inject, Injectable, InternalServerErrorException, NotFoundException, UnauthorizedException } from "@nestjs/common";
import { FileUpload } from "graphql-upload";
import { FileService } from "src/file/file.service";
import { TagService } from "src/tag/tag.service";
import { User } from "src/user/user.entity";
import {  FindManyOptions, FindOptionsWhere, Like, Repository,Raw, FindOptionsOrder } from "typeorm";
import { ChangePostInput } from "./dto/change.post.input";
import { PostInput } from "./dto/create.post.input";
import { PostArgs } from "./dto/post.query.args";
import { Post} from "./post.entity";
import { PostView } from "./post.view.entity";

@Injectable()
export class PostService{
    constructor(
        @Inject(process.env.PostRepo)
        private repo: Repository<Post>,
        @Inject(process.env.PostViewRepo)
        private viewRepo: Repository<PostView>,
        private tagSer: TagService,
        private fileServ:FileService
    ){}

    async findAll(args: PostArgs){
        let options: FindManyOptions<PostView> = {}
        options.skip = args.offset;
        options.take = args.first;
        let optionsWhere: FindOptionsWhere<PostView> = {
            title: Like(args.title+"%")
        }
        
        let optionsOrder: FindOptionsOrder<PostView> = {
            [args.sort.by]:args.sort.order
        }
        options.order = optionsOrder;
        options.where = optionsWhere
        if(args.tags){
            options.where.tag = Raw((alias)=>`${alias} @> :tags`,{tags: args.tags})
            
        }
        if(args.filter){
            if(args.filter.includes('createdIn24')){
                options.where["createdIn24"] = true;
                options.order = {
                    dateCreated: 'DESC'
                },
                options.order[args.sort.by] = args.sort.order;
                
            }else{
                options.order = {
                    [args.filter]:"DESC",
                    [args.sort.by]:args.sort.order
                };
                
            }
            
        }
        let result: PostView[]
        try{
            result = await this.viewRepo.find(options)
        }catch(err){
            throw new InternalServerErrorException('Failed to load posts')
        }

        return result
    }

    async createPost(newPost: PostInput,userId:number,files?:Promise<FileUpload>[]){
        const post = this.repo.create({
            text:newPost.text,
            title:newPost.title,
            authorId:userId
        });   
        let createdPost: Post;
        try{
            createdPost = await this.repo.save(post,{data:{tags:newPost.tags}})
        }catch(err){
            throw new InternalServerErrorException('Failed to post')
        }
        if(files){
            await this.fileServ.addFiles(createdPost,files)
        }
        return await this.getPost(createdPost.id);
    }

    async getPost(postId:number){
        let post: PostView;
        try{
            post = await this.viewRepo.findOneByOrFail({id:postId})
        }catch(err){
            throw new NotFoundException()
        }
        return post;
    }

    async changePost(args: ChangePostInput, post: Post, addFiles?: Promise<FileUpload>[],deleteFiles?:string[]){
        Object.assign(post,args)
        if(args.tags){
            post.posttags = await this.tagSer.changeTags(args.tags,post)
        }
        try{
            await this.repo.save(post)
        }catch(err){
            throw new InternalServerErrorException('Failed to update post')
        }
        if(addFiles){
            await this.fileServ.addFiles(post,addFiles)
        }
        if(deleteFiles){
            await this.fileServ.deleteFiles(post,deleteFiles)
        }
        return await this.getPost(post.id)
    }

    async deletePost(postId:number, user: User){
        let deletedPost: Post;
        try{
            deletedPost = await this.repo.findOneOrFail({
                relations:{
                    comments:true
                },
                where:{
                    id:postId,
                    authorId:user.id
                }
            })
        }catch(err){
            throw new UnauthorizedException('FORBIDDEN')
        }
        await this.fileServ.deleteFiles(deletedPost);
        for(let i: number = 0;i < deletedPost.comments.length;i++){
            await this.fileServ.deleteFiles(deletedPost.comments[i])
        }
        try{
            deletedPost = await this.repo.remove(deletedPost)
        }catch(err){
            throw new InternalServerErrorException('Failed to delete')
        }
        return deletedPost;
    }
}