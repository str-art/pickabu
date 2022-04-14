import { PostView } from "src/post/post.view.entity";
import { AfterLoad, BeforeInsert, EntitySubscriberInterface, EventSubscriber, FindOptionsWhere, InsertEvent, LoadEvent } from "typeorm";
import { SavedView } from "./save.view.entity";
import { Saved } from "./saved.entity";

@EventSubscriber()
export class SavedSubscriber implements EntitySubscriberInterface<Saved>{
    listenTo(): string | Function {
        return Saved;
    }


    @BeforeInsert()
    async beforeInsert(event: InsertEvent<Saved>){
        const entity = event.entity;
        const repo = event.connection.getRepository(Saved)
        let f: FindOptionsWhere<Saved> = {};
        for(const key in entity){
            f[key] = entity[key]
        }
        let exist: Saved;
        try{
            exist = await repo.findOneByOrFail(f)
            await repo.remove(exist);
            event.queryRunner.release();
        }catch(err){
            return;
        }
    }
}