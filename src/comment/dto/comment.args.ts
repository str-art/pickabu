import { ArgsType, Field } from "@nestjs/graphql";
import { PaginationArgs } from "src/post/dto/pagination.args";
import { SortOptions } from "src/post/types/sort.options.type";

@ArgsType()
export class CommentArgs extends PaginationArgs{
    @Field(type => SortOptions)
    sort?: SortOptions;
}