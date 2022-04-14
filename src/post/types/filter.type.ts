import { registerEnumType } from "@nestjs/graphql";

export enum Filter{
    newest = 'createdIn24',
    hottest = 'commentsInLast24',
    best = 'likesIn24'
}

registerEnumType(
    Filter,
    {
        name:'FilterOptions'
    }
)
