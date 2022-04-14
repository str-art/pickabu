import { Field, Int, ObjectType } from "@nestjs/graphql";
import { access_token } from "src/auth/access.token";
import { Comment } from "src/comment/comment.entity";
import { Post } from "src/post/post.entity";
import { Reaction } from "src/reaction/reaction.entity";
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";


@ObjectType()
@Entity()
export class User{
    @Field(type => Int)
    @PrimaryGeneratedColumn()
    id:number;

    @Field()
    @Column({unique:true})
    email:string;

    @Column({nullable:false,select:false})
    password:string;

    @OneToMany(()=>Post,post=>post.author)
    posts: Post[];

    @OneToMany(()=>Comment, comment => comment.author)
    comments:Comment[]

    @OneToMany(()=>Reaction, reaction => reaction.user)
    reactions:Reaction[]

    
}

