FROM frolvlad/alpine-oraclejdk8:slim
ADD spring-boot-cli-1.5.1.RELEASE.tar /usr/lib/
RUN ln -s /usr/lib/spring-1.5.1.RELEASE/bin/spring /usr/bin/spring \
    && spring --version

COPY jms /usr/lib/jms
WORKDIR /usr/lib/jms
CMD ["spring" "shell"]