import { Field, InputType } from "@nestjs/graphql";
import { IsArray, IsNotEmpty, IsOptional, IsString } from "class-validator";
import { FileUpload, GraphQLUpload } from "graphql-upload";

@InputType()
export class PostInput{
    @IsNotEmpty()
    @IsString()
    @Field()
    text:string;

    @IsNotEmpty()
    @IsString()
    @Field()
    title: string;

    @Field(type => [String],{nullable:true})
    @IsOptional()
    @IsString({
        each:true
    })
    @IsArray({
    })
    tags?:string[];

    @Field(type => [GraphQLUpload],{nullable:true})
    files?:Promise<FileUpload>[]
}