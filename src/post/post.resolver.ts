import { UseGuards } from "@nestjs/common";
import { Args, Int, Mutation, Parent, Query, ResolveField, Resolver } from "@nestjs/graphql";
import { AuthGuard } from "src/auth/guards/auth.guard";
import { PostGuard } from "src/auth/guards/post.guard";
import { Comment } from "src/comment/comment.entity";
import { CommentService } from "src/comment/comment.service";
import { CommentArgs } from "src/comment/dto/comment.args";
import { getPost } from "src/decorators/post.decorator";
import { getUser } from "src/decorators/user.decorator";
import { File } from "src/file/file.entity";
import { FileService } from "src/file/file.service";
import { ReactionArgs } from "src/reaction/dto/reaction.args";
import { ReactionService } from "src/reaction/reaction.service";
import { User } from "src/user/user.entity";
import { AuthorService } from "./author.service";
import { ChangePostInput } from "./dto/change.post.input";
import { PostInput } from "./dto/create.post.input";
import { PostArgs } from "./dto/post.query.args";
import { Post } from "./post.entity";
import { PostService } from "./post.service";

@Resolver(of=>Post)
export class PostResolver{
    constructor(
        private service: PostService,
        private commentService: CommentService,
        private authorService: AuthorService,
        private reactService: ReactionService,
        private fileService: FileService
        ){}

    @Query(returns => [Post],{name:'posts'})
    async findAllPost(@Args('')args: PostArgs ){
        return await this.service.findAll(args)
    }

    @Query(returns => Post,{name:'post'})
    async getPost(
        @Args('id',{type: ()=> Int}) postId:number){
        return await this.service.getPost(postId)
    }

    @UseGuards(AuthGuard,PostGuard)
    @Mutation(returns => Post,{name:'editPost'})
    async changePost(
        @Args('editPostInput') args: ChangePostInput, 
        @getPost() post: Post,
        ){
        return await this.service.changePost(args,post,args.addFiles,args.deleteFiles)
    }

    @UseGuards(AuthGuard)
    @Mutation(returns => Post,{name:'createPost'})
    async createPost(
        @Args('createPostInput') post: PostInput,
        @getUser() user: User,){
        return await this.service.createPost(post,user.id,post.files)
    }

    @UseGuards(AuthGuard)
    @Mutation(returns => Post,{name:'reactToPost'})
    async react(@Args() reaction: ReactionArgs, @getUser() user: User){
       await this.reactService.postReact(reaction,user.id)
       return await this.service.getPost(reaction.id)
    }

    @UseGuards(AuthGuard)
    @Mutation(returns => Post, {name:'deletePost'})
    async deletePost(
        @Args('id') postId: number, 
        @getUser() user: User
        ){
        return await this.service.deletePost(postId,user)
        }


    @ResolveField('comments',returns => [Comment],{nullable:true})
    async getPostComments(
        @Parent() post: Post,
        @Args() args: CommentArgs){
        const { id } = post
        return await this.commentService.findPostComments(id,args)
    }
    
    @ResolveField('author',returns => User,{nullable:false})
    async getAuthro(@Parent() post: Post){
        return await this.authorService.getAuthor(post.authorId)
    }

    @ResolveField('files', returns => [File],{nullable:true})
    async getFiles(@Parent() post: Post){
        return this.fileService.getFileKeys(post)
    }
}