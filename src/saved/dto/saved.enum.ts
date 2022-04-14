import { registerEnumType } from "@nestjs/graphql";

export enum SaveEntity{
    COMMENT = "comment",
    POST = "post"
}

registerEnumType(
    SaveEntity,
    {
        name:'WhatToSave'
    }
)
