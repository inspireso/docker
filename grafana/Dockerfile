FROM debian:jessie-slim

RUN apt-get update \
    && apt-get -y --no-install-recommends install curl libfontconfig adduser\
    && apt-get clean \
    && curl -v --insecure https://grafanarel.s3.amazonaws.com/builds/grafana_4.1.2-1486989747_amd64.deb -o grafana.deb \
    && dpkg -i grafana.deb \
    && rm -f grafana.deb \
    && apt-get remove -y curl \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*


VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000
#
#COPY ./run.sh /run.sh

CMD exec /usr/sbin/grafana-server --config=/etc/grafana/grafana.ini  cfg:default.paths.data="$GF_PATHS_DATA" cfg:default.paths.logs="$GF_PATHS_LOGS" cfg:default.paths.plugins="$GF_PATHS_PLUGINS"