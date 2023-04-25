FROM ubuntu:18.04

# Installing prerequisite packages
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y tzdata keyboard-configuration
RUN apt-get -y install curl unzip groff less
# AWS CLI installation commands
RUN	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN	unzip awscliv2.zip && ./aws/install

FROM node:lts-alpine
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package.json ./
RUN npm install 
COPY . .
EXPOSE 3000
USER node
CMD ["node", "server.js"]
