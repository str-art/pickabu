import { Comment } from "src/comment/comment.entity";
import { Post } from "src/post/post.entity";
import { User } from "src/user/user.entity";
import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class Saved{
    @PrimaryGeneratedColumn()
    id: number;

    @Column({nullable:true})
    postId:number;

    @ManyToOne(()=>Post,{orphanedRowAction:'delete'})
    post: Post;

    @Column({nullable:true})
    commentId:number;

    @ManyToOne(()=>Comment,{orphanedRowAction:'delete'})
    comment: Comment;

    @Column()
    userId:number;

    @ManyToOne(()=>User,{orphanedRowAction:"delete"})
    user:User;

}
