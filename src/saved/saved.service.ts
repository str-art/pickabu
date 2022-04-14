import { Inject, Injectable, InternalServerErrorException } from "@nestjs/common";
import { User } from "src/user/user.entity";
import { Repository } from "typeorm";
import { SaveInput } from "./dto/saved.input";
import { SavedView } from "./save.view.entity";
import { Saved } from "./saved.entity";
import { PostComment } from "./saved.type";

@Injectable()
export class SavedService{
    constructor(
        @Inject(process.env.SavedView)
        private repo: Repository<SavedView>,
        @Inject(process.env.SavedRepo)
        private entRepo: Repository<Saved>
    ){}
    async getSaved(userId: number):Promise<PostComment[]>{
        let saved: SavedView[];
        try{
            saved = await this.repo.find({
                where:{
                    userId: userId
                }
            })
        }catch(err){
            throw new InternalServerErrorException('failed to load saved posts')
        }
        
        return saved.map((s)=>{
            if(s.post.id)return s.post
            if(s.comment.id)return s.comment
        });
    }


    async save(args: SaveInput, userId:number):Promise<PostComment>{
        let newSaved = new Saved();
        newSaved.userId = userId;
        newSaved[args.entity+'Id'] = args.id;
        try{
            newSaved = await this.entRepo.save(newSaved)
        }catch(err){
            if(err.name == "QueryRunnerAlreadyReleasedError"){
                return null;
            }else{
                throw new InternalServerErrorException(`Failed to save ${args.entity}`)
            }
        }
        const ent = await this.repo.findOneBy({
            id:newSaved.id
        })
        if(ent.comment.id)return ent.comment;
        if(ent.post.id)return ent.post;

    }
}