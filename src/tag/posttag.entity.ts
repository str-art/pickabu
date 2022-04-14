import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Post } from "../post/post.entity";
import { Tag } from "./tag.entity";

@Entity({name:'post_tags'})
export class PostTag{
    @PrimaryGeneratedColumn()
    id?: number;

    @ManyToOne(()=>Post,post => post.posttags,{orphanedRowAction:'delete',nullable:false,onDelete:'CASCADE'})
    post?: Post;

    @Column({nullable:false})
    postId: number;

    @ManyToOne(()=>Tag, tag=>tag.posts,{orphanedRowAction:'delete',nullable:false,onDelete:'CASCADE'})
    tag?: Tag

    @Column({nullable:false})
    tagId:number;

}