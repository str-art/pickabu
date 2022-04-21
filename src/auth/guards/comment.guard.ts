import { CanActivate, ExecutionContext, Inject, Injectable } from "@nestjs/common";
import { GqlExecutionContext } from "@nestjs/graphql";
import { Comment } from "src/comment/comment.entity";
import { Post } from "src/post/post.entity";
import { User } from "src/user/user.entity";
import { Repository } from "typeorm";

@Injectable()
export class CommentGuard implements CanActivate{
    constructor(
        @Inject(process.env.CommentRepo)
        private commentRepo: Repository<Comment>,
        @Inject(process.env.PostRepo)
        private postRepo:Repository<Post>
    ){}
    async canActivate(context: ExecutionContext): Promise<boolean> {

        const ctx = GqlExecutionContext.create(context);
        const user: User = ctx.getContext().req.user;
        const info = ctx.getInfo()
        const args = ctx.getArgs()
        let comment: Comment;
        try{
            comment = await this.commentRepo.findOneByOrFail({id:args.editCommentInput.id,authorId:user.id})
            ctx.getContext().req.comment = comment;
            return true
        }catch(err){
            if(info.fieldName == 'DeleteComment'){
                try{
                    const {comments} = await this.postRepo.findOneOrFail({
                        relations:{
                            comments:true
                        },
                        select:{
                            comments:{
                                id:true,
                                postId:true,
                                authorId:true,
                                text:true,
                                dateCreated:true
                            }
                        },
                        where:{
                            authorId:user.id,
                            comments:{
                                id:args.id
                            }
                        }
                    })
                    ctx.getContext().req.comment = comments[0]
                    return true
                }catch(err){
                    return false
                }
            }
            return false
        }
    }
}