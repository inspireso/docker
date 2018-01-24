FROM centos:7
RUN yum install -y tar
COPY tengine-2.2.0-centos7-with-jemalloc.tar.gz /tmp/tengine.tar.gz
RUN tar xzvf /tmp/tengine.tar.gz -C / && systemctl enable nginx

EXPOSE 80 443
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]