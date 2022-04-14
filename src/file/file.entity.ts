import { Field, ObjectType } from "@nestjs/graphql";
import { Comment } from "src/comment/comment.entity";
import { Post } from "src/post/post.entity";
import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";

@Entity()
@ObjectType()
export class File{
    @PrimaryGeneratedColumn()
    id: number;

    @Field(type => String,{nullable:false})
    @Column({type:'uuid'})
    key:string;

    @Column({nullable:true})
    postId:number;

    @ManyToOne(()=>Post)
    post: Post;

    @Column({nullable:true})
    commentId:number;

    @ManyToOne(()=>Comment)
    comment: Comment

    @Column({nullable:false,default:"image/jpeg"})
    mimetype:string;
}