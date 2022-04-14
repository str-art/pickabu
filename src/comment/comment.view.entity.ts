import { ViewColumn, ViewEntity } from "typeorm";
import { Comment } from "./comment.entity";

@ViewEntity({
    expression:
    `SELECT
    "c".id AS "id",
    "c"."dateCreated" AS "dateCreated",
    "c"."postId" AS "postId",
    "c"."text" AS "text",
    "c"."authorId" AS "authorId",
    COUNT(
        DISTINCT
        CASE
        WHEN "r"."type" = 'LIKE' THEN "r"."id"
        END
    ) AS "likes",
    COUNT(
        DISTINCT
        CASE
        WHEN "r"."type" = 'DISLIKE' THEN "r"."id"
        END
    ) AS "dislikes"
    FROM comment AS "c"
    LEFT JOIN reaction AS "r"
    ON "r"."commentId" = "c"."id"
    GROUP BY "c"."id";`
})
export class CommentView extends Comment{
    @ViewColumn()
    likes:number;

    @ViewColumn()
    dislikes: number;
}