import { Module } from "@nestjs/common";
import { JwtModule } from "@nestjs/jwt";
import { AuthModule } from "src/auth/auth.module";
import { DatabaseModule } from "src/database/db.module";
import { SavedResolver } from "./saved.resolver";
import { SavedService } from "./saved.service";

@Module({
    providers:[SavedResolver,SavedService],
    imports:[
        DatabaseModule,
        JwtModule.register({

            secret:process.env.SECRET,
        }),
        AuthModule]
})
export class SavedModule{}