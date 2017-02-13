FROM fluent/fluentd:v0.14

COPY fluent.conf /fluentd/etc/

USER root

RUN apk add --update --virtual .build-deps \
    sudo build-base ruby-dev \

    # cutomize following instruction as you wish
    && sudo -u fluent gem install \
        fluent-plugin-kubernetes_metadata_filter \
        fluent-plugin-elasticsearch \
        fluent-plugin-prometheus \

    && sudo -u fluent gem sources --clear-all \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* \
       /home/fluent/.gem/ruby/2.3.0/cache/*.gem

USER fluent