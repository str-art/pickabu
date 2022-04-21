import { Module } from "@nestjs/common";
import { DatabaseModule } from "src/database/db.module";
import { TagService } from "./tag.service";

@Module({
    providers:[TagService],
    exports:[TagService],
    imports:[DatabaseModule]
})
export class TagModule{}