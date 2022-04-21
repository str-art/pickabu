import { Module } from "@nestjs/common";
import { DatabaseModule } from "src/database/db.module";
import { UserService } from "./user.service";

@Module({
    imports:[DatabaseModule],
    providers:[UserService]
})
export class UserModule{}