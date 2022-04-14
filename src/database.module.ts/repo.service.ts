import { Comment } from "src/comment/comment.entity";
import { CommentView } from "src/comment/comment.view.entity";
import { database } from "src/data-source";
import { File } from "src/file/file.entity";
import { Post} from "src/post/post.entity";
import { PostView } from "src/post/post.view.entity";
import { Reaction } from "src/reaction/reaction.entity";
import { SavedView } from "src/saved/save.view.entity";
import { Saved } from "src/saved/saved.entity";
import { Tag } from "src/tag/tag.entity";
import { User } from "src/user/user.entity";

export const Providers = [
    {
        provide: process.env.PostRepo,
        useFactory: () => database.getRepository(Post)
    },
    {
        provide: process.env.CommentRepo,
        useFactory: () => database.getRepository(Comment)
    },
    {
        provide: process.env.PostViewRepo,
        useFactory: () => database.getRepository(PostView)
    },
    {
        provide: process.env.UserRepo,
        useFactory: () => database.getRepository(User)
    },
    {
        provide: process.env.ReactionRepo,
        useFactory: () => database.getRepository(Reaction)
    },
    {
        provide: process.env.TagRepo,
        useFactory: ()=> database.getRepository(Tag)
    },
    {
        provide: process.env.FileRepo,
        useFactory: ()=>database.getRepository(File)
    },
    {
        provide: process.env.CommentView,
        useFactory: ()=>database.getRepository(CommentView)
    },
    {
        provide: process.env.SavedView,
        useFactory: ()=>database.getRepository(SavedView)
    },
    {
        provide: process.env.SavedRepo,
        useFactory: ()=>database.getRepository(Saved)
    }

]