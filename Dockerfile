FROM node:9-alpine

EXPOSE 3000

WORKDIR /usr/src/app/

CMD [ "npm", "start" ]

COPY package.json /usr/src/app/

RUN npm install

COPY . /usr/src/app/
