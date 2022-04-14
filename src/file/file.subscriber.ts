import { BeforeInsert, BeforeRemove, EntitySubscriberInterface, EventSubscriber, InsertEvent, RemoveEvent } from "typeorm";
import { BucketService } from "./bucket.service";
import { v4 as uuidv4 } from 'uuid';
import { File } from "./file.entity";
import { Readable } from "stream";

@EventSubscriber()
export class FileSubscriber implements EntitySubscriberInterface<File>{
    constructor(){
        this.storage = new BucketService()
    }
    private storage: BucketService;

    listenTo(): string | Function {
        return File;
    }


    @BeforeInsert()
    async beforeInsert(event: InsertEvent<File>): Promise<void>{
        const file: Readable = event.queryRunner.data.file;
        const entity = event.entity;
        const filename:string = uuidv4()
        await this.storage.upload(file,filename);
        entity.key = filename
    }

    @BeforeRemove()
    async beforeRemove(event: RemoveEvent<File>){
        const key = event.entity.key;
        await this.storage.delete(key);
        console.log(key,"removed")
    }
}