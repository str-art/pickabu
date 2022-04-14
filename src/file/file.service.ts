import { HttpException, HttpStatus, Inject, Injectable, InternalServerErrorException } from "@nestjs/common";
import { FileUpload} from "graphql-upload";
import { FindOptionsWhere, In, Repository } from "typeorm";
import { BucketService } from "./bucket.service";
import { File } from "./file.entity";
import { Readable } from "stream";
import { GetObjectCommandOutput } from "@aws-sdk/client-s3";

@Injectable()
export class FileService{
    constructor(
        @Inject(process.env.FileRepo)
        private repo: Repository<File>,
        private bucket: BucketService
    ){}

    

    async addFiles<T extends {id: number, files: File[] | File, postId?: number}>(entity: T ,uploads:Promise<FileUpload>[]){
        uploads.forEach(async(f)=>{
            const file = await f;
            let stream: Readable;
            try{
                stream = file.createReadStream()
            }catch(err){
                throw new HttpException({
                    status: HttpStatus.BAD_REQUEST,
                    message: `File is too big`
                },HttpStatus.BAD_REQUEST)
            }
            if(entity.postId){
                await this.repo.save({commentId:entity.id,mimetype:file.mimetype},{data:{file:stream}})
            }else{
                await this.repo.save({postId:entity.id,mimetype:file.mimetype},{data:{file:stream}})
            }
        })
    }

    async getFileKeys<T extends {id:number, postId?: number}>(entity: T){
        let options: FindOptionsWhere<File> = {};
        if(entity.postId){
            options.commentId=entity.id;
        }else{options.postId = entity.id}
        let files: File[];
        try{
            files = await this.repo.findBy(options)
        }catch(err){
            console.log(err)
            return
        }
        return files;
    }

    async getFile(key:string){
        let type: string
        try{
            const{ mimetype } = await this.repo.findOneOrFail({
                select:{
                    mimetype:true
                },
                where:{
                    key:key
                }
            })
            type = mimetype;
        }catch(err){
            throw new InternalServerErrorException('File not found')
        }
         
        let object: Readable;
        try{
            const a:GetObjectCommandOutput = await this.bucket.download(key)
            object = a.Body as Readable;
        }catch(err){
            throw new InternalServerErrorException('Failed to load')
        }
        return {object,type}
    }

    async deleteFiles<T extends {id:number,postId?:number}>(entity: T,keys?:string[],){
        let options: FindOptionsWhere<File> = {};
        if(entity.postId){
            options.commentId = entity.id
        }else{
            options.postId = entity.id
        }
        if(keys)options.key = In(keys);
        const files = await this.repo.findBy(options)
        if(!files)return;
        await this.repo.remove(files)
    }
}