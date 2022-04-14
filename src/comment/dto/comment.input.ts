import { Field, InputType, Int } from "@nestjs/graphql";
import { IsNotEmpty, IsPositive, IsString } from "class-validator";
import { FileUpload, GraphQLUpload } from "graphql-upload";

@InputType()
export class CommentInput{
    @Field()
    @IsNotEmpty()
    @IsString()
    text:string;

    @Field(type=>Int)
    @IsNotEmpty()
    @IsPositive()
    postId: number;

    @Field(type => [GraphQLUpload],{nullable:true})
    files?: Promise<FileUpload>[]

    
}