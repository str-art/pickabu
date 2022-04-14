import { Field, GraphQLTimestamp, Int, ObjectType } from "@nestjs/graphql";
import { File } from "src/file/file.entity";
import { Post } from "src/post/post.entity";
import { Reaction } from "src/reaction/reaction.entity";
import { User } from "src/user/user.entity";
import { Column, CreateDateColumn, Entity, In, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";

@Entity({
    orderBy:{
        dateCreated:'DESC'
        }
    })
@ObjectType()
export class Comment{
    @PrimaryGeneratedColumn()
    @Field(type => Int)
    id:number;

    @Column()
    @Field()
    text:string;

    @ManyToOne(()=>Post,post=>post.comments,{onDelete:'CASCADE'})
    post:Post

    @Column()
    postId:number;

    @CreateDateColumn()
    @Field(type => GraphQLTimestamp)
    dateCreated: Date

    @Column({nullable:false})
    authorId:number;

    @Field(type => User)
    @ManyToOne(()=>User, user=>user.comments,{onDelete:'CASCADE'})
    author: User;

    @OneToMany(()=>Reaction,reaction=>reaction.comment)
    reactions:Reaction[]

    @Field(type => [File],{nullable:true})
    @OneToMany(()=>File,file=>file.comment)
    files:File[]

    @Field(type => Int)
    likes:number;

    @Field(type => Int)
    dislikes:number;
}