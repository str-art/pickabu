import { ArgsType, Field, Int } from "@nestjs/graphql";
import { IsNumber, IsPositive } from "class-validator";

@ArgsType()
export class PaginationArgs{
    @IsPositive()
    @Field(type => Int)
    first: number = 10;

    @IsNumber()
    @Field(type => Int)
    offset: number = 0;
}