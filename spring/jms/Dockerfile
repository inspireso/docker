FROM inspireso/spring-boot-cli:1.5.1
MAINTAINER lan.xinen "<lan.xinen@inspireso.org>"

ADD app /usr/jms
RUN spring --version \
    && ls -l -a /usr/jms/

WORKDIR /usr/jms
CMD ["spring", "run", "/usr/jms/app.groovy"]