FROM debian:jessie-slim

RUN apt-get update \
    && apt-get -y --no-install-recommends install curl \
    && apt-get clean \
    && curl -v --insecure https://grafanarel.s3.amazonaws.com/builds/grafana_4.1.2-1486989747_amd64.deb -o grafana.deb \
    && dpkg -i grafana.deb \
    && rm -f grafana.deb \
    && apt-get remove -y wget \
    && apt-get autoremove -y && \
    && rm -rf /var/lib/apt/lists/*


VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

COPY ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]