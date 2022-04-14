import { HttpException, HttpStatus, Inject, Injectable } from "@nestjs/common";
import { User } from "src/user/user.entity";
import { Repository } from "typeorm";

@Injectable()
export class AuthorService{
    constructor(
        @Inject(process.env.UserRepo)
        private repo: Repository<User>
    ){}

    async getAuthor(id:number){
        let author: User;
        try{
            author = await this.repo.findOneByOrFail({
                id:id
            })
        }catch(err){
            throw new HttpException({
                status:HttpStatus.INTERNAL_SERVER_ERROR,
                message:`Author not found`
            },HttpStatus.INTERNAL_SERVER_ERROR)
        }
        return author;
    }
}