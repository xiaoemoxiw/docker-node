FROM node:10.15.3
MAINTAINER yuxuewen <8586826@qq.com>

COPY ./sources.list /etc/apt/sources.list.aliyun

RUN cp -r /etc/apt/sources.list /etc/apt/sources.list.init && \
    cat /etc/apt/sources.list.aliyun > /etc/apt/sources.list && \
    cat /etc/apt/sources.list.init >> /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y \
        vim \
        zip \
        unzip \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && yarn config set registry https://registry.npm.taobao.org \
    && npm install -g cnpm --registry=https://registry.npm.taobao.org \
    && cnpm install --save-dev babel-preset-react \
    && cnpm install --save-dev babel-preset-es2015 \
    && cnpm install -g webpack \
    && cnpm install -g less

COPY ./schedulerx2Agent-1.0.0-SNAPSHOT.tar.gz /opt/schedulerx2Agent-1.0.0-SNAPSHOT.tar.gz
RUN tar zxf /opt/schedulerx2Agent-1.0.0-SNAPSHOT.tar.gz



