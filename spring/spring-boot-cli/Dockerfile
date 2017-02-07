FROM frolvlad/alpine-oraclejdk8:slim
MAINTAINER lan.xinen "<lan.xinen@inspireso.org>"

#ADD spring-1.5.1.RELEASE.tar /usr/lib/
RUN wget http://repo.spring.io/release/org/springframework/boot/spring-boot-cli/1.5.1.RELEASE/spring-boot-cli-1.5.1.RELEASE-bin.tar.gz \
    | tar -xzvf /usr/lib/ \
    && ls -l /usr/lib/ \
    && sed -i "s|#!/usr/bin/env bash|#!/bin/sh|g" /usr/lib/spring-1.5.1.RELEASE/bin/spring \
    && ln -s /usr/lib/spring-1.5.1.RELEASE/bin/spring /usr/bin/spring \
    && spring --version
CMD ["spring" "shell"]