import { IsNotEmpty, IsUUID } from "class-validator";


export class GetFile{
    @IsNotEmpty()
    @IsUUID()
    key:string;
}