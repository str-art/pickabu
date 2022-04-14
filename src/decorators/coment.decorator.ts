import { createParamDecorator, ExecutionContext } from "@nestjs/common";
import { GqlExecutionContext } from "@nestjs/graphql";

export const getComment = createParamDecorator(
    (data: any, ctx: ExecutionContext)=>{
        const context = GqlExecutionContext.create(ctx).getContext()
        return context.req.comment
    }
)