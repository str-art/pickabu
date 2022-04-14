
import { ViewEntity, ViewColumn } from "typeorm";
import { Post } from "./post.entity";

@ViewEntity(
    {
        expression:
        `
        SELECT 
        "Post".id AS "id",
        "Post".text AS "text",
        "Post".title AS "title",
        "Post"."dateCreated"::timestamp AS "dateCreated",
        "Post"."authorId" AS "authorId",
        COUNT(DISTINCT "Comment".id) AS "totalComments",
        COUNT(DISTINCT
            CASE
            WHEN EXTRACT(DAY FROM CURRENT_TIMESTAMP::timestamp - "Comment"."dateCreated"::timestamp) = 0 THEN "Comment".id
            END) AS "commentsInLast24",
        COUNT(DISTINCT
            CASE 
            WHEN "Reaction".type = 'LIKE' THEN "Reaction".id
            END) AS "likes",
        COUNT(DISTINCT
            CASE
            WHEN "Reaction".type = 'DISLIKE' THEN "Reaction".id
            END) AS "dislikes",
        COUNT(DISTINCT
            CASE
            WHEN EXTRACT(DAY FROM CURRENT_TIMESTAMP::timestamp - "Reaction"."dateCreated"::timestamp) = 0 AND "Reaction".type = 'LIKE' THEN "Reaction".id
            END) AS "likesIn24",
        COUNT(DISTINCT
            CASE
            WHEN EXTRACT(DAY FROM CURRENT_TIMESTAMP::timestamp - "Reaction"."dateCreated"::timestamp) = 0 AND "Reaction".type = 'DISLIKE' THEN "Reaction".id
            END) AS "dislikesIn24",
        CASE
        WHEN EXTRACT(DAY FROM CURRENT_TIMESTAMP::timestamp - "Post"."dateCreated"::timestamp) = 0 THEN TRUE
        ELSE FALSE
        END AS "createdIn24",
        STRING_AGG(
            "Tag".tag ,
            '#'
        ) AS "tags",
        ARRAY_REMOVE(ARRAY_AGG(
           DISTINCT "Tag".tag
        ),NULL) AS "tag"
        FROM post AS "Post"
        LEFT JOIN comment AS "Comment"
        ON "Post".id = "Comment"."postId"
        LEFT JOIN reaction AS "Reaction"
        ON "Post".id = "Reaction"."postId"
        LEFT JOIN "user" AS "User"
        ON "Reaction"."userId" = "User".id
        LEFT JOIN post_tags AS "pt"
        ON "Post".id = "pt"."postId"
        LEFT JOIN tag AS "Tag"
        ON "pt"."tagId" = "Tag".id
        GROUP BY "Post".id;
        `
    }
)
export class PostView extends Post{
    @ViewColumn()
    id: number;

    @ViewColumn()
    text: string;

    @ViewColumn()
    title: string;

    @ViewColumn()
    totalComments:number;

    @ViewColumn()
    dateCreated: Date;

    @ViewColumn()
    commentsInLast24:number;

    @ViewColumn()
    authorId: number;

    @ViewColumn()
    likes:number;

    @ViewColumn()
    dislikes:number;

    @ViewColumn()
    tag: string[];

    @ViewColumn()
    createdIn24: boolean;

    @ViewColumn()
    likesIn24: number;
}