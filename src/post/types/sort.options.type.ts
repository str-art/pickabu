import { Field, InputType, registerEnumType } from "@nestjs/graphql";

@InputType()
export class SortOptions{
    @Field(type => SortOptionsColumn,{nullable: false})
    by?:SortOptionsColumn = SortOptionsColumn.DATE;

    @Field(type => SortOptionsOrder,{nullable:false})
    order?:SortOptionsOrder = SortOptionsOrder.DESC;
}

export enum SortOptionsOrder{
    ASC = 'ASC',
    DESC = 'DESC'
}
export enum SortOptionsColumn{
    LIKES = 'likes',
    DATE = 'dateCreated'
}

registerEnumType(
    SortOptionsColumn,
    {
        name:'SortingOptionsColumn',
    }
)

registerEnumType(
    SortOptionsOrder,
    {
        name:'SortOptionsOrder'
    }
)