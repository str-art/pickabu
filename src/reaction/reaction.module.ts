import { Module } from "@nestjs/common";
import { DatabaseModule } from "src/database.module.ts/db.module";
import { ReactionService } from "./reaction.service";

@Module({
    providers:[ReactionService],
    imports:[DatabaseModule],
    exports:[ReactionService]
})
export class ReactionModule{}