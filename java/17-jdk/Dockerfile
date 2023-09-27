FROM eclipse-temurin:17-jdk-focal

ENV LANG zh_CN.UTF-8

ARG MIRROR_DEBIAN_HOST=mirrors.aliyun.com

# if use mirror change to aliyun mirror site
RUN sed -i "s/ports.ubuntu.com/${MIRROR_DEBIAN_HOST}/g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends dos2unix tini ttf-dejavu && \
    echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen zh_CN.UTF-8 && \
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

# add app user
RUN groupadd -g 1001 app && useradd -m -d /app -u 1001 -g app app && \
    chown -R app:app /opt
USER app    