FROM openjdk:8-jre-alpine

ENV LANG zh_CN.UTF-8

ARG MIRROR_ALPINE_HOST=mirrors.aliyun.com

# if use mirror change to aliyun mirror site
RUN sed -i "s/dl-cdn.alpinelinux.org/${MIRROR_ALPINE_HOST}/g" /etc/apk/repositories && \
    apk upgrade --no-cache && \
    apk add --no-cache curl tini libc6-compat fontconfig ttf-dejavu ca-certificates tzdata && \
    apk upgrade --no-cache openjdk8 && \
    rm -rf /var/apk/* && \
    java -version

# Tini is now available at /sbin/tini
ENTRYPOINT ["/sbin/tini", "--"]

# copy arthas
COPY --from=hengyunabc/arthas:latest /opt/arthas /opt/arthas

# add app user
RUN addgroup -g 1001 -S app && adduser  -u 1001 -S app -G app && \
    chown -R app:app /opt
USER app