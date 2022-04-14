import { Field, InputType, Int } from "@nestjs/graphql";
import { IsOptional, IsPositive, IsString, IsUUID } from "class-validator";
import { FileUpload, GraphQLUpload } from "graphql-upload";

@InputType()
export class ChangePostInput{
    @IsPositive()
    @Field(type => Int)
    id:number;

    @IsOptional()
    @IsString()
    @Field({nullable:true})
    text?:string;

    @IsString()
    @Field({nullable: true})
    title?:string;

    @IsOptional()
    @IsString({
        each:true
    })
    @Field(type => [String],{nullable:true})
    tags?:string[];

    @IsUUID(4,{
        each:true
    })
    @Field(type => [String],{nullable: true})
    deleteFiles?:string[];


    @Field(type => [GraphQLUpload],{nullable: true})
    addFiles?: Promise<FileUpload>[];
}