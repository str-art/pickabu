import { DataSource } from "typeorm";

export const database = new DataSource({
    type:'postgres',
    port:5432,
    host: process.env.POSTGRES_HOST,
    username:process.env.POSTGRES_USER || "postgres",
    password:process.env.POSTGRES_PASSWORD || "PICKABU",
    database:process.env.POSTGRES_DB || "pickabu",
    entities:["dist/**/*.entity{.ts,.js}"],
    synchronize:true,
    logging:'all',
    subscribers:["dist/**/*.subscriber{.ts,.js}"],
    migrations: ["dist/**/*.migration{.ts,.js}"],
})
