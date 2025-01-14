FROM node:12.10-buster

WORKDIR /app

COPY package.json /app/
COPY yarn.lock /app/

RUN yarn install --production && yarn cache clean

RUN iptables -P INPUT ACCEPT
RUN iptables-save > /etc/network/iptables.rules

COPY . /app

ENV NODE_ENV production
ENTRYPOINT ["node", "-r", "esm", "./bin/server"]
