import { ArgsType, Field, Int } from "@nestjs/graphql";
import { IsNumber, IsPositive } from "class-validator";
import { ReactionType } from "../reaction.entity";

@ArgsType()
export class ReactionArgs{
    @IsNumber()
    @IsPositive()
    @Field(type => Int,{description:'id of entity to react'})
    id:number;

    @Field(type => ReactionType)
    type: ReactionType
}