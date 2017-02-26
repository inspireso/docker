FROM debian:jessie-slim

USER root

RUN apt-get update \
    && apt-get -y --no-install-recommends install curl libfontconfig adduser\
    && apt-get clean \
    && curl -v --insecure https://grafanarel.s3.amazonaws.com/builds/grafana_4.1.2-1486989747_amd64.deb -o grafana.deb \
    && curl -sSL -o /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.9/gosu-$(dpkg --print-architecture)" \
    && chmod +x /usr/local/bin/gosu \
    && dpkg -i grafana.deb \
    && rm -f grafana.deb \
    && apt-get remove -y curl \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3000

COPY ./run.sh /run.sh

CMD ["sh", "/run.sh"]