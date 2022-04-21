import { ApolloDriver, ApolloDriverConfig } from '@nestjs/apollo';
import { Module } from '@nestjs/common';
import { GraphQLModule } from '@nestjs/graphql';
import { JwtModule } from '@nestjs/jwt';
import { join } from 'path';
import { AuthModule } from './auth/auth.module';
import { CommentModule } from './comment/comment.module';
import { DatabaseModule } from './database/db.module';
import { FileModule } from './file/file.module';
import { PostModule } from './post/post.module';
import { SavedModule } from './saved/saved.module';
import { UserModule } from './user/user.module';


@Module({
  imports: [
    GraphQLModule.forRoot<ApolloDriverConfig>({
      driver: ApolloDriver,
      autoSchemaFile: join(process.cwd(), 'src/schema.gql'),

    }),
    JwtModule.register({
      secret:process.env.SECRET,
      verifyOptions:{
        ignoreExpiration:true
      }
    }),
    PostModule,
    DatabaseModule,
    CommentModule,
    AuthModule,
    UserModule,
    FileModule,
    SavedModule
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
