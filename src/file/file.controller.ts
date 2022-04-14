import { Body, Controller, Get, Param, StreamableFile } from "@nestjs/common";
import { GetFile } from "./dto/file.dto";
import { FileService } from "./file.service";

@Controller('file')
export class FileController {
    constructor(
        private service: FileService
    ){}


    @Get()
    async getFile(@Body()getFile:GetFile ){
        const file = await this.service.getFile(getFile.key);
        return new StreamableFile(file.object,{type:file.type})
    }
}