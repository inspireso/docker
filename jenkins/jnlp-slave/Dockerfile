FROM jenkinsci/jnlp-slave:2.62-alpine

USER root

RUN set -x \
    && apk add --no-cache subversion
    && rm -rf /var/cache/apk/*

USER jenkins