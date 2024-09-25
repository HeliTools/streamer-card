FROM node:20-alpine

LABEL authors="ygh3279799773"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update && apk add chromium

# 安装中文字体和 fontconfig
RUN apk add --update ttf-dejavu font-droid-nonlatin fontconfig && \
    rm -rf /var/cache/apk/* && \
    mkfontscale && mkfontdir && fc-cache

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

WORKDIR /app

COPY . .

RUN yarn config set registry https://registry.npmmirror.com/ && yarn install

WORKDIR /app

EXPOSE 3003

CMD [ "npm", "start" ]
