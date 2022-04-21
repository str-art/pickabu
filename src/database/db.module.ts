import { Module } from "@nestjs/common";
import { Providers } from "./repo.service";

@Module({
    providers:[...Providers],
    exports:[...Providers]
})
export class DatabaseModule{}