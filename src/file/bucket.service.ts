import { Injectable, InternalServerErrorException } from "@nestjs/common";
import { S3Client, PutObjectCommand, DeleteObjectCommand, GetObjectCommand, DeleteObjectCommandOutput, GetObjectCommandOutput } from "@aws-sdk/client-s3"
import { Readable } from "stream";

@Injectable()
export class BucketService extends S3Client {
    constructor(){
        super({
            credentials:{
                accessKeyId:process.env.S3_KEY,
                secretAccessKey:process.env.S3_SECRET
            },
            endpoint:"https://storage.yandexcloud.net",
            region:'ru-central1'
        });
    }

    async upload(file: Readable, filename: string){
        try{
            await this.send(new PutObjectCommand({Bucket:process.env.S3_BUCKET,Key:`${filename}`,Body:file}))
        }catch(err){
            console.log(err)
            throw new InternalServerErrorException('Failed to save file')
        }
    }

    async delete(key:string){
        let a: DeleteObjectCommandOutput;
        try{
            a = await this.send(new DeleteObjectCommand({Bucket:process.env.S3_BUCKET,Key:key}))
        }catch(err){
            console.log(err)
            throw new InternalServerErrorException(`Failed to delete object`)
        }
        return a
    }

    async download(key:string){
        let object: GetObjectCommandOutput
        try{
            object = await this.send(new GetObjectCommand({Bucket:process.env.S3_BUCKET,Key:key}))
            
        }
        catch(err){
            console.log(err)
            throw new InternalServerErrorException('Failed to load object')
        }
        return object
    }
}