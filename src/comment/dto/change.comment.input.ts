import { Field, InputType, Int } from "@nestjs/graphql";
import { IsNotEmpty, IsOptional, IsPositive, IsString } from "class-validator";
import { FileUpload, GraphQLUpload } from "graphql-upload";

@InputType()
export class ChangeCommentInput{
    @IsNotEmpty()
    @IsPositive()
    @Field(type => Int)
    id:number;

    @IsOptional()
    @IsString()
    @Field(type => String)
    text?: string;

    @Field(type=>[GraphQLUpload],{nullable:true})
    addFiles?:Promise<FileUpload>[];

    @Field(type=>[String],{nullable:true})
    deleteFiles?:string[]
}