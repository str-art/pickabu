import { InternalServerErrorException } from "@nestjs/common";
import { AfterInsert, EntitySubscriberInterface, EventSubscriber, InsertEvent, InsertResult } from "typeorm";
import { Post } from "./post.entity";
import { PostTag } from "../tag/posttag.entity";
import { Tag } from "../tag/tag.entity";

@EventSubscriber()
export class PostSubscriber implements EntitySubscriberInterface<Post>{
    constructor(){
    }
    listenTo(): string | Function {
        return Post
    }

    

    @AfterInsert()
    async afterInsert(event: InsertEvent<any>){
       const post: Post = event.entity;
       const ptRepo = event.manager.getRepository(PostTag);
       const tags: string[] = event.queryRunner.data.tags;
       const tagRepo = event.manager.getRepository(Tag);
       const entities = [...new Set(tags)].map((e)=>{
           return {tag:e}
       })
       let existing: InsertResult;
       try{
        existing = await tagRepo.upsert(entities,['tag'])
       }catch(err){
           throw new InternalServerErrorException('Failed to post')
       }
       const postTags = existing.identifiers.map((i)=>{
           return {postId:post.id,tagId:i.id}
       })
       try{
           await ptRepo.save(postTags)
       }catch(err){
           throw new InternalServerErrorException('falied to post')
       }

    }

    
}