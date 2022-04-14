import { HttpException, HttpStatus, Inject, Injectable } from "@nestjs/common";
import { Repository, TypeORMError } from "typeorm";
import { ReactionArgs } from "./dto/reaction.args";
import { Reaction } from "./reaction.entity";

@Injectable()
export class ReactionService{
    constructor(
        @Inject(process.env.ReactionRepo)
        private repo: Repository<Reaction>
    ){}

    async postReact(args: ReactionArgs, userId:number){
        
        const reaction = this.repo.create({postId:args.id,type:args.type,userId})
        
        try{
            await this.repo.save(reaction)
        }catch(err){
            if(err.name != "QueryRunnerAlreadyReleasedError"){
                throw new HttpException({
                    status:HttpStatus.INTERNAL_SERVER_ERROR,
                    message: `Cant react`
                }, HttpStatus.INTERNAL_SERVER_ERROR)
            }
        }
    }

    async commentReact(args: ReactionArgs, userId: number){
        const reaction = this.repo.create({commentId:args.id,type:args.type,userId})
        
        try{
            await this.repo.save(reaction)
        }catch(err){
            if(err.name != "QueryRunnerAlreadyReleasedError"){
                throw new HttpException({
                    status:HttpStatus.INTERNAL_SERVER_ERROR,
                    message: `Cant react`
                }, HttpStatus.INTERNAL_SERVER_ERROR)
            }
        }
    }
}