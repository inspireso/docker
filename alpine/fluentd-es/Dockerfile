FROM registry.cn-hangzhou.aliyuncs.com/base_containers/fluentd:v0.14

RUN \
  apk add --update --virtual .build-deps \
    build-base \
    ruby-dev \

  # cutomize following instruction as you wish
  && gem install \
      fluent-plugin-elasticsearch \
  && gem sources --clear-all \
  && apk del .build-deps \
  && rm -rf /var/cache/apk/* \
  && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem