FROM inspireso/java:8-jre-alpine

ARG NEXUS_VERSION=3.3.0-01
ARG NEXUS_DOWNLOAD_URL=https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz


# configure nexus runtime
ENV SONATYPE_DIR=/opt/sonatype
ENV NEXUS_HOME=${SONATYPE_DIR}/nexus
ENV NEXUS_DATA=/nexus-data
ENV NEXUS_CONTEXT=''
ENV SONATYPE_WORK=${SONATYPE_DIR}/sonatype-work
ENV INSTALL4J_ADD_VM_PARAMS="-Xms1200m -Xmx1200m"

# install nexus
RUN apk add --no-cache openssl && \
    apk add --no-cache --virtual=build-deps wget ca-certificates && \
    mkdir -p "${SONATYPE_DIR}" && \
    cd "${SONATYPE_DIR}" && \
    wget ${NEXUS_DOWNLOAD_URL} -O - | tar zx -C "${SONATYPE_DIR}" && \
    mv "${SONATYPE_DIR}/nexus-${NEXUS_VERSION}" "${NEXUS_HOME}" && \
    mkdir -p "${NEXUS_DATA}/etc" "${NEXUS_DATA}/log" "${NEXUS_DATA}/tmp" "${SONATYPE_WORK}" && \
    ln -s "${NEXUS_DATA}" "${SONATYPE_WORK}/nexus3" && \
    apk del build-deps && \
    rm -rf /var/cache/apk/* &&\
    rm -rf /tmp/*

# configure nexus
RUN sed \
    -e '/^nexus-context/ s:$:${NEXUS_CONTEXT}:' \
    -i ${NEXUS_HOME}/etc/nexus-default.properties \
    && sed \
    -e '/^-Xms/d' \
    -e '/^-Xmx/d' \
    -i ${NEXUS_HOME}/bin/nexus.vmoptions

VOLUME ${NEXUS_DATA}

EXPOSE 8081

WORKDIR ${NEXUS_HOME}

CMD ["bin/nexus", "run"]