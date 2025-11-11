FROM node:24-alpine3.21

RUN set -eux; \
    apk add --no-cache python3 py3-pip \
    && ln -sf python3 /usr/bin/python \
    && mkdir -p /etc \
    && echo '[global]\nindex-url = https://mirrors.ustc.edu.cn/pypi/web/simple' > /etc/pip.conf \
    && pip install --no-cache-dir --upgrade pip

RUN corepack enable && corepack prepare pnpm@latest --activate
