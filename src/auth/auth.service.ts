import { HttpException, HttpStatus, Inject, Injectable, UnauthorizedException } from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import { User } from "src/user/user.entity";
import { Repository } from "typeorm";
import { Credentials } from "./dto/credentials";
import { NewUser } from "./dto/user.input";

@Injectable()
export class AuthService{
    constructor(
        @Inject(process.env.UserRepo)
        private repo: Repository<User>,
        private jwt: JwtService
    ){}

    async register(newUser:NewUser){
        let createdUser: User;

        try{
            createdUser = await this.repo.save(newUser)
        }
        catch(err){
            throw new HttpException({
                status:HttpStatus.CONFLICT,
                message: `${newUser.email} is already in use`
            },HttpStatus.CONFLICT)
        }
        return this.login(createdUser);
    }

    login(user:User){
        const { password, ...userToLog} = user;
        return {
            access_token:this.jwt.sign({sub:userToLog.id,username:userToLog.email}),
            user: userToLog
        }
    }

    async validateUser(creds:Credentials){
        let user: User;
        try{
            user = await this.repo.findOneOrFail({
                where:{
                    email:creds.email,
                    password:creds.password
                }
            })
        }
        catch(err)
        {
            throw new HttpException({
                status:HttpStatus.UNAUTHORIZED,
                message: `Wrong credentials`
            },HttpStatus.UNAUTHORIZED)
        }
        return this.login(user)
    }

    async getUser(id:number){
        let user: User
        try{
            user = await this.repo.findOneByOrFail({
                id:id
            })
        }
        catch(err){
            throw new UnauthorizedException()
        }
        return user;
    }
}