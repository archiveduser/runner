FROM node:24-trixie

# 换 Apt 源到 USTC（适配 debian.sources 格式）
RUN set -eux; \
    sed -i 's|http://deb.debian.org|https://mirrors.ustc.edu.cn|g' /etc/apt/sources.list.d/debian.sources; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        python3-pip python-is-python3 \
        ca-certificates tzdata git; \
    rm -rf /var/lib/apt/lists/*

# 设置 pip 源为 USTC（全局）
RUN set -eux; \
    mkdir -p /etc; \
    printf '%s\n' \
      '[global]' \
      'index-url = https://mirrors.ustc.edu.cn/pypi/web/simple' \
      > /etc/pip.conf

ENV PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1

# 设置 npm 源为国内镜像（全局）并安装 pnpm
# Node 24 自带 corepack；优先用 corepack 安装，失败时回退 npm 全局安装
RUN set -eux; \
    printf 'registry=https://registry.npmmirror.com\n' > /etc/npmrc; \
    corepack enable; \
    corepack prepare pnpm@latest --activate || npm i -g pnpm

# 可选：验证版本（构建日志可见）
RUN node -v && npm -v && pnpm -v && python -V && pip -V
