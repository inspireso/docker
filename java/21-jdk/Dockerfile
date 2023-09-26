FROM openjdk:21-jdk-buster

ENV LANG zh_CN.UTF-8

ARG MIRROR_DEBIAN_HOST=mirrors.aliyun.com

# if use mirror change to aliyun mirror site
RUN sed -i "s/deb.debian.org/${MIRROR_DEBIAN_HOST}/g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends locales tini ttf-dejavu ca-certificates tzdata dos2unix && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8 && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    java -version

# Tini is now available at /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# copy arthas
COPY --from=hengyunabc/arthas:latest /opt/arthas /opt/arthas

COPY /rootfs /
CMD ["/bin/sh", "/run.sh"]

# add app user
RUN groupadd -g 1001 app && useradd -m -d /app -u 1001 -g app app && \
    chown -R app:app /opt
USER app    
