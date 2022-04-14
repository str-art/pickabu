import { CommentView } from "src/comment/comment.view.entity";
import { PostView } from "src/post/post.view.entity";
import { Column, ViewColumn, ViewEntity } from "typeorm";

@ViewEntity({
    expression:`
    SELECT
    "s"."id" AS "id",
    "s"."userId" AS "userId",
    "pv"."id" AS "postId",
    "pv"."text" AS "postText",
    "pv"."title" AS "postTitle",
    "pv"."authorId" AS "postAuthorid",
    "pv"."likes" AS "postLikes",
    "pv"."dislikes" AS "postDislikes",
    "pv"."tag" AS "postTag",
    "pv"."dateCreated" AS "postDatecreated",
    "pv"."totalComments" AS "postTotalcomments",
    "pv"."commentsInLast24" AS "postCommentsinlast24",
    "pv"."createdIn24" AS "postCreatedin24",
    "pv"."likesIn24" AS "postLikesin24",
    "cv"."id" AS "commentId",
    "cv"."text" AS "commentText",
    "cv"."likes" AS "commentLikes",
    "cv"."dislikes" AS "commentDislikes",
    "cv"."authorId" AS "commentAuthorid",
    "cv"."postId" AS "commentPostid",
    "cv"."dateCreated" AS "commentDatecreated"
    FROM saved AS "s"
    LEFT JOIN post_view AS "pv"
    ON "s"."postId" = "pv"."id"
    LEFT JOIN comment_view AS "cv"
    ON "s"."commentId" = "cv"."id";
    `,
    dependsOn: [PostView,CommentView]
})
export class SavedView{
    @ViewColumn()
    id:number;

    @Column(()=>PostView)
    post:PostView;

    @Column(()=>CommentView)
    comment: CommentView

    @ViewColumn()
    userId:number;
}