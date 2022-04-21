import { Module } from "@nestjs/common";
import { JwtModule } from "@nestjs/jwt";
import { AuthModule } from "src/auth/auth.module";
import { CommentModule } from "src/comment/comment.module";
import { DatabaseModule } from "src/database/db.module";
import { FileModule } from "src/file/file.module";
import { ReactionModule } from "src/reaction/reaction.module";
import { TagModule } from "src/tag/tag.module";
import { AuthorService } from "./author.service";
import { PostResolver } from "./post.resolver";
import { PostService } from "./post.service";

@Module({
    imports:[
        DatabaseModule,
        CommentModule,
        AuthModule,
        JwtModule.register({
            secret:process.env.SECRET,
            verifyOptions:{
                ignoreExpiration:true
              }
        }),
        ReactionModule,
        TagModule,
        FileModule
    ],
    providers:[PostService,PostResolver,AuthorService]
})
export class PostModule{}