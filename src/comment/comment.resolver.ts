import { UseGuards } from "@nestjs/common";
import { Args, Int, Mutation, Parent, ResolveField, Resolver } from "@nestjs/graphql";
import { AuthGuard } from "src/auth/guards/auth.guard";
import { CommentGuard } from "src/auth/guards/comment.guard";
import { getComment } from "src/decorators/coment.decorator";
import { getUser } from "src/decorators/user.decorator";
import { File } from "src/file/file.entity";
import { FileService } from "src/file/file.service";
import { ReactionArgs } from "src/reaction/dto/reaction.args";
import { ReactionService } from "src/reaction/reaction.service";
import { User } from "src/user/user.entity";
import { Comment } from "./comment.entity";
import { CommentService } from "./comment.service";
import { ChangeCommentInput } from "./dto/change.comment.input";
import { CommentInput } from "./dto/comment.input";

@Resolver((of) => Comment)
export class CommentResolver{
    constructor(
         private service: CommentService,
         private reactService: ReactionService,
         private fileService: FileService
         ){}

     @UseGuards(AuthGuard)
     @Mutation(returns => Comment,{name:'reactToComment'})
     async react(@Args() reaction: ReactionArgs, @getUser() user: User){
          await this.reactService.commentReact(reaction,user.id)
          return this.service.getComment(reaction.id)
     }

     @UseGuards(AuthGuard)
     @Mutation(returns => Comment,{name: 'createComment'})
     async createComment(
          @Args('commentInput') comment: CommentInput, 
          @getUser() user: User,
          ){
          return await this.service.createComment(comment,user,comment.files)
     }

     @UseGuards(AuthGuard,CommentGuard)
     @Mutation(returns => Comment,{name:'editComment'})
     async editComment(
          @Args('editCommentInput',{nullable:false, type: () => ChangeCommentInput}) changes: ChangeCommentInput,
          @getComment() comment: Comment,
          ){
          return await this.service.changeComment(changes,comment,changes.deleteFiles,changes.addFiles)
     }

     @UseGuards(AuthGuard,CommentGuard)
     @Mutation(returns => Comment,{name:"deleteComment",nullable:true})
     async deleteComment(
          @Args('id',{nullable:false}) id: number, 
          @getComment()comment: Comment){
          await this.service.deleteComment(comment);
          comment.id = id;
          return comment;
     }

     @ResolveField('author',returns => User)
     async getAuthor(@Parent() comment: Comment){
          return await this.service.getAuthor(comment)
     }

     @ResolveField('files',returns => [File])
     async getFiles(@Parent() comment: Comment){
          return await this.fileService.getFileKeys(comment)
     }
}