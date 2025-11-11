FROM node:24-alpine3.21

RUN apk add --no-cache python3 py3-pip git

RUN corepack enable && corepack prepare pnpm@latest --activate
