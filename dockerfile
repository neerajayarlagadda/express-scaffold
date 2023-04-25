FROM node:lts-alpine
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package.json ./
RUN npm install 

RUN apt update && apt upgrade
apt install curl
apt install sudo
apt-get install zip
apt-get install unzip
apt-get install python3
apt install python3.8-venv
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"

COPY . .
EXPOSE 3000
USER node
CMD ["node", "server.js"]
