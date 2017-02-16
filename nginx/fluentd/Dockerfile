FROM registry.cn-hangzhou.aliyuncs.com/base_containers/fluentd:es

RUN fluentd --setup /etc/fluentd

COPY fluent.conf /etc/fluentd/

CMD exec fluentd -c /etc/fluentd/fluent.conf