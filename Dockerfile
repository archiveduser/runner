FROM node:24-alpine3.21

RUN set -eux; \
    apk add --no-cache python3 py3-pip git; \
    mkdir -p /etc; \
    echo '[global]' > /etc/pip.conf; \
    echo 'break-system-packages = true' >> /etc/pip.conf; \
    echo 'disable-pip-version-check = true' >> /etc/pip.conf; \
    echo 'no-cache-dir = true' >> /etc/pip.conf

RUN corepack enable && corepack prepare pnpm@latest --activate
