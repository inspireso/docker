FROM  registry.cn-hangzhou.aliyuncs.com/base_containers/debian:jessie-slim-gosu

ARG user=grafana
ARG group=grafana
ARG uid=1002
ARG gid=1002

ENV GRAFANA_USER root
ENV GRAFANA_GROUP root

RUN groupadd -g ${gid} ${group} \
    && useradd -d "/usr/share/grafana" -u ${uid} -g ${gid} -m -s /bin/false ${user}

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libfontconfig  wget \
    && apt-get clean \
    && wget -O grafana.deb "https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_4.5.2_amd64.deb" \
    && dpkg -i grafana.deb \
    && rm -f grafana.deb \
    && apt-get purge -y --auto-remove ca-certificates wget \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3000

COPY ./run.sh /run.sh

RUN chmod +x /run.sh

ENTRYPOINT ["sh", "/run.sh"]
