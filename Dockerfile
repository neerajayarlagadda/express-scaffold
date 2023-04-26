FROM ubuntu:18.04

# May be optional if these packages are installed already in the base image
RUN apt-get update && apt-get install -y curl unzip groff

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
	./aws/install
    RUN aws --version
FROM node:19-bullseye
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package.json ./
RUN npm install 



COPY . .
EXPOSE 3000
USER node
CMD ["node", "server.js"]
