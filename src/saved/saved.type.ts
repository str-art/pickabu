import { createUnionType } from "@nestjs/graphql";
import { Comment } from "src/comment/comment.entity";
import { CommentView } from "src/comment/comment.view.entity";
import { Post } from "src/post/post.entity";
import { PostView } from "src/post/post.view.entity";

export const SavedObjects = createUnionType({
    name:"Saved",
    types: ()=>[Post, Comment] as const,
    resolveType(value){
        if(value.postId){
            return Comment
        }
        if(value.title){
            return Post
        }
        return null
    }
    
})

export type PostComment = 
    | Post
    | Comment

