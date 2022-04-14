import { HttpException, HttpStatus, Inject, Injectable } from "@nestjs/common";
import { Repository } from "typeorm";
import { User } from "./user.entity";

@Injectable()
export class UserService{
    constructor(
        @Inject(process.env.UserRepo)
        private repo:Repository<User>
    ){}
    
    async getUser(id:number){
        let user:User;
        try{
            user = await this.repo.findOneByOrFail({
                id:id
            })
        }catch(err){
            throw new HttpException({
                status: HttpStatus.NOT_FOUND,
                message: `User not found`
            },HttpStatus.NOT_FOUND)
        }
        return user;
    }
}