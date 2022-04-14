import { UseGuards } from "@nestjs/common";
import { Args, Mutation, Query, Resolver } from "@nestjs/graphql";
import { AuthGuard } from "src/auth/guards/auth.guard";
import { getUser } from "src/decorators/user.decorator";
import { User } from "src/user/user.entity";
import { SaveInput } from "./dto/saved.input";
import { SavedService } from "./saved.service";
import { SavedObjects } from "./saved.type";

@Resolver(of => SavedObjects)
export class SavedResolver{
    constructor(
        private service: SavedService
    ){}

    @UseGuards(AuthGuard)
    @Query(returns => [SavedObjects],{nullable:true})
    async getSaved(
        @getUser() user: User
    ){
        return await this.service.getSaved(user.id)
    }

    @UseGuards(AuthGuard)
    @Mutation(returns => SavedObjects,{nullable:true,name:"saveEntity"})
    async saveSomething(
        @Args('saveInput') args: SaveInput,
        @getUser() user: User,
    ){
        const a = await this.service.save(args,user.id)
        console.log(a)
        return a;
    }

}