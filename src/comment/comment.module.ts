import { Module } from "@nestjs/common";
import { JwtModule } from "@nestjs/jwt";
import { AuthModule } from "src/auth/auth.module";
import { DatabaseModule } from "src/database.module.ts/db.module";
import { FileModule } from "src/file/file.module";
import { ReactionModule } from "src/reaction/reaction.module";
import { CommentResolver } from "./comment.resolver";
import { CommentService } from "./comment.service";

@Module({
    imports:[
        DatabaseModule,
        AuthModule,
        JwtModule.register({
            secret:process.env.SECRET
        }),
        ReactionModule,
        FileModule
    ],
    providers:[CommentResolver,CommentService],
    exports:[CommentService]
})
export class CommentModule{}