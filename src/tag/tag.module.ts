import { Module } from "@nestjs/common";
import { DatabaseModule } from "src/database.module.ts/db.module";
import { TagService } from "./tag.service";

@Module({
    providers:[TagService],
    exports:[TagService],
    imports:[DatabaseModule]
})
export class TagModule{}