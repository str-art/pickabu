import { Module } from "@nestjs/common";
import { DatabaseModule } from "src/database/db.module";
import { ReactionService } from "./reaction.service";

@Module({
    providers:[ReactionService],
    imports:[DatabaseModule],
    exports:[ReactionService]
})
export class ReactionModule{}