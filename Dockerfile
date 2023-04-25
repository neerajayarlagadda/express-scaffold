FROM node:lts-alpine
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package.json ./
RUN npm install 

RUN apk update && apk upgrade
/apk install curl
/apk install sudo
/apk install zip
/apk install unzip
/apk install python3
/apk install python3.8-venv
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"

RUN pip3 --no-cache-dir install --upgrade awscli

COPY . .
EXPOSE 3000
USER node
CMD ["node", "server.js"]
