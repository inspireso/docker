FROM  registry.cn-hangzhou.aliyuncs.com/base_containers/debian:jessie-slim-gosu

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
    && wget -O grafana.deb "https://grafanarel.s3.amazonaws.com/builds/grafana_4.1.2-1486989747_amd64.deb" \
    && dpkg -i grafana.deb \
    && rm -f grafana.deb \
    && apt-get purge -y --auto-remove ca-certificates wget \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3000

COPY ./run.sh /run.sh

RUN chmod +x /run.sh

ENTRYPOINT ["sh", "/run.sh"]