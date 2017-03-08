FROM jenkinsci/jnlp-slave:2.62-alpine

ENV KUBE_VERSION v1.5.1

USER root

RUN apk update \
    && apk upgrade \
    && apk add subversion

RUN set -x \
    && apk add --no-cache --virtual .build-deps \
        openssl \
    && wget -O /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$KUBE_VERSION/bin/linux/amd64/kubectl" \
    && chmod +x /usr/local/bin/kubectl \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

COPY .npmrc /home/jenkins/.npmrc
COPY .yarnrc /home/jenkins/.yarnrc
#USER jenkins
