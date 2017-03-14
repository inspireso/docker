FROM jenkinsci/jnlp-slave:2.62-alpine


USER root

RUN set -x \
    && apk add --no-cache \
      openssl \
      ca-certificates \
      subversion

#添加kubectl工具
ENV KUBE_VERSION v1.5.1

RUN set -x \
    && wget -O /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$KUBE_VERSION/bin/linux/amd64/kubectl" \
    && chmod +x /usr/local/bin/kubectl \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*


#添加docker工具
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.12.6
ENV DOCKER_SHA256 cadc6025c841e034506703a06cf54204e51d0cadfae4bae62628ac648d82efdd

RUN set -x \
    && wget -O docker.tgz "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" \
    && echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
    && tar -xzvf docker.tgz \
    && mv docker/* /usr/local/bin/ \
    && rmdir docker \
    && rm docker.tgz \
    && docker -v


RUN mkdir -p /home/jenkins/cache/.yarn \
    && mkdir -p /home/jenkins/cache/.npm

COPY .npmrc /home/jenkins/.npmrc
COPY .yarnrc /home/jenkins/.yarnrc
#USER jenkins
