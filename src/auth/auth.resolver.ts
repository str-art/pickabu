
import { Args, ResolveField, Resolver,Mutation, Query, Parent, Context  } from "@nestjs/graphql";
import { access_token } from "./access.token";
import { AuthService } from "./auth.service";
import { Credentials } from "./dto/credentials";
import { NewUser } from "./dto/user.input";

@Resolver(of => access_token)
export class AuthResolver{
    constructor(
        private service:AuthService
    ){}

    @Query(returns => access_token,{name:'login'})
    async login(@Args() creds: Credentials){
        return await this.service.validateUser(creds)
    }

    @Mutation(returns => access_token,{name:'register'})
    async register(@Args('newUserInput') user: NewUser){
        return await this.service.register(user)
    }
}