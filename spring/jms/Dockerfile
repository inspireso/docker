FROM inspireso/spring-boot-cli:1.5.1
MAINTAINER lan.xinen "<lan.xinen@inspireso.org>"

COPY app /usr/jms
COPY ext /usr/lib/spring-1.5.1.RELEASE/lib/ext
RUN spring --version \
    && spring install org.influxdb:influxdb-java:2.5 \
    && ls -l /usr/lib/spring-1.5.1.RELEASE/lib/ext/

WORKDIR /usr/jms
CMD ["spring", "run", "app.groovy"]