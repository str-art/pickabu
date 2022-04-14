import { Field, GraphQLTimestamp, Int, ObjectType } from "@nestjs/graphql";
import { Comment } from "src/comment/comment.entity";
import { File } from "src/file/file.entity";
import { Reaction } from "src/reaction/reaction.entity";
import { User } from "src/user/user.entity";
import { Column, CreateDateColumn, Entity,ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { PostTag } from "../tag/posttag.entity";

@Entity({orderBy:{
    dateCreated:'DESC'
}})
@ObjectType()
export class Post{

    @PrimaryGeneratedColumn()
    @Field(type=>Int,{nullable:true})
    id:number;

    @Column()
    @Field()
    text:string;

    @Column()
    @Field()
    title:string;

    @CreateDateColumn()
    @Field(type => GraphQLTimestamp)
    dateCreated: Date;

    @Field(type => [Comment],{nullable:true})
    @OneToMany(()=>Comment, comment => comment.post)
    comments:Comment[]    

    @Field(type => Int)
    totalComments:number;

    @Column()
    authorId:number;

    @Field(type=>User)
    @ManyToOne(()=>User,user=>user.posts,{onDelete:'CASCADE'})
    author: User

    @OneToMany(()=>Reaction,reaction => reaction.post)
    reactions: Reaction[]

    @Field(type => Int,{nullable: false, defaultValue: 0})
    likes:number;

    @Field(type => Int,{nullable: false,defaultValue: 0})
    dislikes: number;

    @OneToMany(()=>PostTag, pt=>pt.post,{cascade:['insert','remove']})
    posttags?: PostTag[];

    @Field(type => [String],{nullable:'itemsAndList'})
    tag?:string[]

    @Field(type => [File],{nullable:true})
    @OneToMany(()=>File,file=>file.post)
    files: File[]
}

