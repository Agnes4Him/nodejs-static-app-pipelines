FROM node:alpine

WORKDIR /app

COPY ./package*.json /app/

RUN npm install

COPY . /app/

EXPOSE 5555

CMD [ "node", "server.js" ]