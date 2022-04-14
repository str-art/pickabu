import { HttpException, HttpStatus } from "@nestjs/common";
import { BeforeInsert, EntitySubscriberInterface, EventSubscriber, InsertEvent } from "typeorm";
import { Reaction } from "./reaction.entity";

@EventSubscriber()
export class ReactionSubscriber implements EntitySubscriberInterface<Reaction>{
    
    listenTo(): string | Function {
        return Reaction
    }

    @BeforeInsert()
    async beforeInsert(event: InsertEvent<Reaction>){
        const reaction = event.entity
        const repo = event.manager.getRepository(Reaction)
        let exist: Reaction;
        if(reaction.postId){
            try{
                exist = await repo.findOneByOrFail({postId:reaction.postId,userId:reaction.userId})
            }catch(err){
                return null;
            }
        }
        if(reaction.commentId){
            try{
                exist = await repo.findOneByOrFail({commentId:reaction.commentId,userId:reaction.userId})
            }catch(err){
                return null;
            }
        }
        if(exist.type == reaction.type){
            try{
                await repo.remove(exist)
            }catch(err){
                throw new HttpException({
                    status:HttpStatus.INTERNAL_SERVER_ERROR,
                    message:`Something went wrong`
                },HttpStatus.INTERNAL_SERVER_ERROR)
            }
            event.queryRunner.release()
        } else {
            try{
                await repo.update({id:exist.id},{type: reaction.type})
            }catch(err){
                throw new HttpException({
                    status:HttpStatus.INTERNAL_SERVER_ERROR,
                    message:`Something went wrong`
                },HttpStatus.INTERNAL_SERVER_ERROR)
            }
            event.queryRunner.release()
        }
        
    }
}