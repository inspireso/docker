FROM alpine:3.5

# Do not split this into multiple RUN!
# Docker creates a layer for every RUN-Statement
# therefore an 'apk delete' has no effect
RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
      ca-certificates \
      ruby ruby-irb \
  && apk add --no-cache --virtual .build-deps \
      build-base \
      ruby-dev \
  && update-ca-certificates \
  && echo 'gem: --no-document' >> /etc/gemrc \
  && gem install oj \
  && gem install json \
  && gem install fluentd -v 0.14.12 \
  && apk del .build-deps \
  && rm -rf /var/cache/apk/* \
  && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

CMD ["sh"]