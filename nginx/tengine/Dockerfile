FROM centos:6.7
RUN yum install -y tar
COPY tengine-2.1.2-centos6.7.tar.gz /tmp/tengine.tar.gz
RUN tar xzvf /tmp/tengine.tar.gz -C / && chkconfig nginx on

EXPOSE 80 443
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]