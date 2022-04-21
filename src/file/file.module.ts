import { Module } from "@nestjs/common";
import { DatabaseModule } from "src/database/db.module";
import { BucketService } from "./bucket.service";
import { FileController } from "./file.controller";
import { FileService } from "./file.service";

@Module({
    imports:[DatabaseModule],
    controllers:[FileController],
    providers:[BucketService,FileService],
    exports:[FileService]
})
export class FileModule{}