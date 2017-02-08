FROM inspireso/spring-boot-cli:1.5.1
MAINTAINER lan.xinen "<lan.xinen@inspireso.org>"

COPY app /usr/jms
RUN spring --version \
    && ls -l -a /usr/lib/spring-1.5.1.RELEASE/lib/ext/

WORKDIR /usr/jms
CMD ["spring", "run", "/usr/jms/app.groovy"]