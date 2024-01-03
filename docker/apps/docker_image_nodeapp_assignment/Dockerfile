# use this empty Dockerfile to build your assignment

# NOTE: The instructions are now in the README.md file in this directory.

FROM node:6-alpine
# base image node:6-alpine

EXPOSE 3000
# exposing port 3000 in docker virtual network

RUN apk add --no-cache tini
# installing tini package to to base image

WORKDIR /usr/src/app
# changing working directory

COPY package.json package.json

RUN npm install && npm cache clean --force

COPY . .

CMD [ "/sbin/tini", "--", "node", "./bin/www" ]