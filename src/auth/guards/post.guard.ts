import { CanActivate, ExecutionContext, Inject, Injectable } from "@nestjs/common";
import { GqlExecutionContext } from "@nestjs/graphql";
import { ChangePostInput } from "src/post/dto/change.post.input";
import { Post } from "src/post/post.entity";
import { PostView } from "src/post/post.view.entity";
import { User } from "src/user/user.entity";
import { Repository } from "typeorm";

@Injectable()
export class PostGuard implements CanActivate{
    constructor(
        @Inject(process.env.PostViewRepo)
        private repo: Repository<PostView>
    ){}
    async canActivate(context: ExecutionContext):Promise<boolean> {
        const ctx = GqlExecutionContext.create(context)
        const args:ChangePostInput = ctx.getArgs().input
        const user:User = ctx.getContext().req.user
        let post: Post;
        try{
            post = await this.repo.findOneOrFail({
                select:{
                    text:true,
                    title:true,
                    dateCreated:true,
                    authorId:true,
                },
                where:{
                    id:args.id,
                    authorId:user.id
                }
            })
            ctx.getContext().req.post = post;
            return true  
        }catch(err){
            return false
        }
    }
}