FROM maven:3.2-jdk-7-onbuild

USER root

RUN apk update \
    && apk upgrade \
    && apk add subversion \
    && rm -rf /var/cache/apk/*

USER jenkins
