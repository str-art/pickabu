import 'dotenv/config';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { database } from './data-source';
import { ValidationPipe } from '@nestjs/common';
import { graphqlUploadExpress } from 'graphql-upload';

const PORT = process.env.PORT || 3000;

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  database.initialize()
  .then(()=>{
    console.log('DB connection established')
  })
  .catch((err)=>{
    console.log('Failed to connect to DB',err)
  })
  app.useGlobalPipes(new ValidationPipe());
  app.use(graphqlUploadExpress({maxFiles:10,maxFileSize:100000000}))
  await app.listen(PORT);
}
bootstrap();
