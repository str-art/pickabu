import { createParamDecorator, ExecutionContext } from "@nestjs/common"
import { GqlExecutionContext } from "@nestjs/graphql"

export const getPost = createParamDecorator(
    (data: any, ctx: ExecutionContext)=>{
        const context = GqlExecutionContext.create(ctx).getContext()
        return context.req.post
    }
)