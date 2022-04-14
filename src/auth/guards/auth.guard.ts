import { CanActivate, ExecutionContext, Injectable } from "@nestjs/common";
import { GqlExecutionContext } from "@nestjs/graphql";
import { JwtService } from "@nestjs/jwt";
import { Observable } from "rxjs";
import { User } from "src/user/user.entity";
import { AuthService } from "../auth.service";

@Injectable()
export class AuthGuard implements CanActivate{
    constructor(
        private service:AuthService,
        private jwt: JwtService
    ){}
    async canActivate(context: ExecutionContext):Promise<boolean>{
        console.log('asdasd')
        const ctx = GqlExecutionContext.create(context).getContext()
        const tokenHeader:string = ctx.req.rawHeaders.find((header:string)=>header.includes('Bearer'))
        let token:string;
        let user: User;
        try{
            token = tokenHeader.split(' ')[1]
            const {sub, username} = this.jwt.verify(token)
            user = await this.service.getUser(sub)
        }catch(err){
            console.log(token)
            console.log(err)
            return false
        }
        if(user){
            ctx.req.user = user;
            return true
        }
        return false
    }
}