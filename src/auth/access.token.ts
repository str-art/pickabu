import { Field, ObjectType } from "@nestjs/graphql";
import { User } from "src/user/user.entity";

@ObjectType()
export class access_token{
    @Field()
    access_token: string;

    @Field(type => User)
    user: User;
}