import { Module } from "@nestjs/common";
import { JwtModule } from "@nestjs/jwt";
import { DatabaseModule } from "src/database/db.module";
import { AuthResolver } from "./auth.resolver";
import { AuthService } from "./auth.service";
import { AuthGuard } from "./guards/auth.guard";
import { CommentGuard } from "./guards/comment.guard";
import { PostGuard } from "./guards/post.guard";

@Module({
    imports:[
        JwtModule.register({
        secret:process.env.SECRET,
        verifyOptions:{
            ignoreExpiration:true
          }
        }),
        DatabaseModule
    ],
    providers:[AuthResolver,AuthService,AuthGuard,PostGuard,CommentGuard],
    exports:[AuthGuard,AuthService,PostGuard,CommentGuard]
})
export class AuthModule{}