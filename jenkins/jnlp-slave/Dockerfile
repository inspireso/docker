FROM jenkinsci/jnlp-slave:2.62-alpine

RUN set -x \
    && apk add --no-cache subversion
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* /var/tmp/*


COPY run.sh /run.sh
CMD ["sh", "/run.sh"]