FROM openjdk:17-jdk-slim-buster

ENV LANG zh_CN.UTF-8

ARG MIRROR_DEBIAN_HOST=mirrors.aliyun.com

# if use mirror change to aliyun mirror site
RUN sed -i "s/deb.debian.org/${MIRROR_DEBIAN_HOST}/g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/* && \
    java -version

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini
RUN chmod +x /sbin/tini
ENTRYPOINT ["/sbin/tini", "--"]

# copy arthas
COPY --from=hengyunabc/arthas:latest /opt/arthas /opt/arthas

COPY /rootfs /
CMD ["/bin/sh", "/run.sh"]

# add app user
RUN groupadd -g 1001 app && useradd  -u 1001 -g app app && \
    chown -R app:app /opt
USER app

ONBUILD COPY --chown=app:app ./run.sh /run.sh
ONBUILD COPY --chown=app:app ./app /app