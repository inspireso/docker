FROM jenkinsci/jnlp-slave:2.62-alpine

USER root

RUN apk update \
    && apk upgrade \
    && apk add subversion \
    && rm -rf /var/cache/apk/*

USER jenkins
