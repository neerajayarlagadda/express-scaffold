FROM node:lts-alpine
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package.json ./
RUN npm install 

RUN apt-get update

COPY . .
EXPOSE 3000
USER node
CMD ["node", "server.js"]
