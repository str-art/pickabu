import { Field, InputType, Int } from "@nestjs/graphql";
import { SaveEntity } from "./saved.enum";

@InputType()
export class SaveInput{
    @Field(type => Int)
    id: number;

    @Field(type => SaveEntity)
    entity: SaveEntity;
}