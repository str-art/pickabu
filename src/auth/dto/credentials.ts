import { ArgsType, Field } from "@nestjs/graphql";
import { IsEmail, IsNotEmpty } from "class-validator";

@ArgsType()
export class Credentials{
    @IsNotEmpty()
    @IsEmail()
    @Field()
    email:string;

    @IsNotEmpty()
    @Field()
    password:string;
}