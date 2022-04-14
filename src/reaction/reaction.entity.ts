import { registerEnumType } from "@nestjs/graphql";
import { Comment } from "src/comment/comment.entity";
import { Post } from "src/post/post.entity";
import { User } from "src/user/user.entity";
import { Column, CreateDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";

export enum ReactionType{
    like = "LIKE",
    dislike = "DISLIKE"
}

registerEnumType(
    ReactionType,
        {
            name: 'ReactionType'
        }
    )

@Entity()
export class Reaction{
    @PrimaryGeneratedColumn()
    id:number;

    @Column({
        type: 'enum',
        enum: ReactionType,
        default: ReactionType.like
    })
    type:ReactionType;

    @Column({nullable:false})
    userId:number;

    @ManyToOne(()=>User, user => user.reactions,{onDelete:'CASCADE'})
    user: User;

    @Column({nullable:true})
    commentId:number;

    @ManyToOne(()=>Comment, comment=>comment.reactions,{onDelete:'CASCADE'})
    comment: Comment;

    @Column({nullable:true})
    postId:number;

    @ManyToOne(()=>Post, post => post.reactions,{onDelete:'CASCADE'})
    post: Post;

    @CreateDateColumn()
    dateCreated: Date
}

