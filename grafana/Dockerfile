FROM debian:jessie-slim

USER root

ENV GOSU_VERSION 1.10

ARG user=grafana
ARG group=grafana
ARG uid=1002
ARG gid=1002

RUN groupadd -g ${gid} ${group} \
    && useradd -d "/usr/share/grafana" -u ${uid} -g ${gid} -m -s /bin/false ${user}

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libfontconfig  wget \
    && apt-get clean \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && wget -O grafana.deb "https://grafanarel.s3.amazonaws.com/builds/grafana_4.1.2-1486989747_amd64.deb" \
    && dpkg -i grafana.deb \
    && rm -f grafana.deb \
    && apt-get purge -y --auto-remove ca-certificates wget \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3000

COPY ./run.sh /run.sh

RUN chmod +x /run.sh \
  && dos2unix -u /run.sh

ENTRYPOINT ["/run.sh"]