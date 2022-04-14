import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { PostTag } from "./posttag.entity";

@Entity()
export class Tag{
    @PrimaryGeneratedColumn()
    id: number;

    @Column({unique:true})
    tag:string;

    @OneToMany(()=>PostTag,pt=>pt.tag)
    posts: PostTag[];
}

