import { Inject, Injectable, InternalServerErrorException } from "@nestjs/common";
import { Post } from "src/post/post.entity";
import { InsertResult, Repository } from "typeorm";
import { Tag } from "./tag.entity";

@Injectable()
export class TagService{
    constructor(
        @Inject(process.env.TagRepo)
        private repo: Repository<Tag>
    ){}

    async changeTags(tags: string[],post: Post){
        const entities = [... new Set(tags)].map((t)=>{
            return {tag:t}
        })
        let exist: InsertResult;
        try{
            exist = await this.repo.upsert(entities,["tag"])
        }catch(err){
            throw new InternalServerErrorException('Failed to updated tags')
        }
        const postTags = exist.identifiers.map((i:{id:number})=>{
            return {postId: post.id,tagId:i.id}
        })
        return postTags;
    }
}