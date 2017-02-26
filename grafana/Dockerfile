FROM debian:jessie-slim

ENV GOSU_VERSION 1.10

USER root

RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates libfontconfig  wget && rm -rf /var/lib/apt/lists/* \
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
    && apt-get purge -y --auto-remove ca-certificates wget

#    && apt-get -y --no-install-recommends install curl libfontconfig adduser\
#    && apt-get clean \
#    && curl -v --insecure https://grafanarel.s3.amazonaws.com/builds/grafana_4.1.2-1486989747_amd64.deb -o grafana.deb \
#    && dpkg -i grafana.deb \
#    && rm -f grafana.deb \
#    && apt-get remove -y curl \
#    && apt-get autoremove -y \
#    && rm -rf /var/lib/apt/lists/*

EXPOSE 3000

COPY ./run.sh /run.sh

CMD ["sh", "/run.sh"]