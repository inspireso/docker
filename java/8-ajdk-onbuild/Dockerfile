FROM alibabadragonwell/dragonwell:8.14.15-extended-ga-ubuntu

ENV LANG zh_CN.UTF-8

ARG MIRROR_ALPINE_HOST=mirrors.aliyun.com

# if use mirror change to aliyun mirror site
RUN sed -i 's|http://archive.ubuntu.com/ubuntu|http://mirrors.aliyun.com/ubuntu/|' /etc/apt/sources.list && \
    sed -i 's|http://ports.ubuntu.com/ubuntu-ports|http://mirrors.aliyun.com/ubuntu/|' /etc/apt/sources.list && \
    sed -i 's|http://cn.archive.ubuntu.com/ubuntu|http://mirrors.aliyun.com/ubuntu/|' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends dos2unix tini ttf-dejavu ca-certificates tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    java -version

# Tini is now available at /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# copy arthas
COPY --from=hengyunabc/arthas:latest /opt/arthas /opt/arthas

COPY /rootfs /
CMD ["/bin/sh", "/run.sh"]

ONBUILD COPY ./app /app
