FROM node:16-alpine

WORKDIR /usr/src/pickabu

COPY package*.json ./

RUN npm install

COPY . . 

RUN npm run build

EXPOSE 8080

CMD [ "npm" , "start"]