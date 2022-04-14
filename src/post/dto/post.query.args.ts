import { ArgsType, Field} from "@nestjs/graphql";
import { IsArray, IsOptional, IsString } from "class-validator";
import { Filter } from "../types/filter.type";
import { SortOptions, SortOptionsColumn, SortOptionsOrder } from "../types/sort.options.type";
import { PaginationArgs } from "./pagination.args";

@ArgsType()
export class PostArgs extends PaginationArgs{
    @Field(type => SortOptions,{nullable: true})
    sort?: SortOptions = {
        by: SortOptionsColumn.DATE,
        order: SortOptionsOrder.DESC
    }

    @IsString()
    @Field({nullable:true})
    title?: string = '';

    @IsOptional()
    @IsArray()
    @IsString({
        each:true
    })
    @Field(type => [String],{nullable:true})
    tags: string[]

    @Field(type => Filter,{nullable:true})
    filter:Filter
}

