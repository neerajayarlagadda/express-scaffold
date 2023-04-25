FROM node:bullseye
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package.json ./
RUN npm install 

RUN apt update && apt install -y curl unzip groff

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
	./aws/install

RUN aws --version
COPY . .
EXPOSE 3000
USER node
CMD ["node", "server.js"]
