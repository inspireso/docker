FROM debian:jessie-slim

RUN apt-get update \
    && apt-get -y --no-install-recommends install wget \
    && apt-get clean \
    && wget https://grafanarel.s3.amazonaws.com/builds/grafana_4.1.2-1486989747_amd64.deb
    && apt-get install -y adduser libfontconfig \
    && dpkg -i grafana_4.1.2-1486989747_amd64.deb
    && rm -f grafana_4.1.2-1486989747_amd64.deb
    && apt-get remove -y wget \
    && apt-get autoremove -y && \
    && rm -rf /var/lib/apt/lists/*


VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

COPY ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]