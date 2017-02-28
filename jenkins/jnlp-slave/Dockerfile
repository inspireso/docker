FROM jenkinsci/jnlp-slave:2.62-alpine

RUN set -x \
    && apk add --no-cache subversion
    && rm -rf /var/cache/apk/*


COPY run.sh /run.sh
CMD ["sh", "/run.sh"]