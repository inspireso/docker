FROM alpine:latest

MAINTAINER lan.xinen <lan.xinen@inspireso.cn>

ENV TENGINE_VERSION 2.2.2
ENV CONFIG "\
    --prefix=/etc/nginx \
    --sbin-path=/usr/sbin/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --user=nginx \
    --group=nginx \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_auth_request_module \
    --with-mail \
    --with-mail_ssl_module \
    --with-file-aio \
    --with-ipv6 \
    --with-jemalloc \
    --with-http_v2_module \
    "

RUN \
  addgroup -S nginx \
  && adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx \
  && apk add --no-cache --virtual .build-deps \
      gcc \
      libc-dev \
      make \
      openssl-dev \
      pcre-dev \
      zlib-dev \
      linux-headers \
      curl \
      jemalloc-dev \
  && curl -v --insecure "http://tengine.taobao.org/download/tengine-${TENGINE_VERSION}.tar.gz" -o tengine.tar.gz \
  && mkdir -p /usr/src \
  && tar -xzf tengine.tar.gz -C /usr/src/ \
  && rm tengine.tar.gz \
  && cd /usr/src/tengine-$TENGINE_VERSION \
  && ./configure $CONFIG --with-debug \
  && make \
  && mv objs/nginx objs/nginx-debug \
  && ./configure $CONFIG \
  && make \
  && make install \
  && rm -rf /etc/nginx/html/ \
  && mkdir /etc/nginx/conf.d/ \
  && mkdir -p /usr/share/nginx/html/ \
  && install -m644 html/index.html /usr/share/nginx/html/ \
  && install -m644 html/50x.html /usr/share/nginx/html/ \
  && install -m755 objs/nginx-debug /usr/sbin/nginx-debug \
  && strip /usr/sbin/nginx* \
  && runDeps="$( \
    scanelf --needed --nobanner /usr/sbin/nginx \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
  )" \
  && apk add --virtual .nginx-rundeps $runDeps \
  && apk del .build-deps \
  && rm -rf /usr/src/nginx-$NGINX_VERSION \
  && ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]