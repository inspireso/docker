FROM jenkinsci/jnlp-slave:2.62-alpine


USER root

RUN set -x \
    && apk add --no-cache \
      subversion

#添加kubectl工具
ENV KUBE_VERSION v1.5.1

RUN set -x \
    && apk add --no-cache --virtual .build-deps \
        openssl \
    && mkdir -p /usr/local/bin \
    && wget -O /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$KUBE_VERSION/bin/linux/amd64/kubectl" \
    && chmod +x /usr/local/bin/kubectl \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*


#添加docker工具
ENV DOCKER_VERSION 1.12.5

COPY docker /usr/local/bin/

RUN mkdir -p /home/jenkins/cache/.yarn \
    && mkdir -p /home/jenkins/cache/.npm

COPY .npmrc /home/jenkins/.npmrc
COPY .yarnrc /home/jenkins/.yarnrc
#USER jenkins
