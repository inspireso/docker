# tengine镜像

- fluentd: 用于收集日志
- tengine: 基于tengine2.1.3的镜像


## 编译/安装tengine

 ```sh
$ ./configure  \
	--user=nginx \
  	--group=nginx \
  	--pid-path=/var/run/nginx.pid \
  	--lock-path=/var/run/nginx.lock \
  	--http-client-body-temp-path=/var/cache/nginx/client_temp \
  	--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp
$ make
$ make install
$ ln -s /usr/local/nginx/sbin/nginx /usr/local/sbin/nginx
$ cat <<EOF > /usr/lib/systemd/system/nginx.service
[Unit]
Description=nginx - high performance web server
Documentation=http://nginx.org/en/docs/
After=network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
ExecStartPre=/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf
ExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID

[Install]
WantedBy=multi-user.target

EOF

# 打包
$ tar -zcvf tengine-2.2.0-centos7.tar.gz /usr/local/nginx /usr/local/sbin/nginx /usr/lib/systemd/system/nginx.service
 ```

## install

```sh
$ curl -v -o tengine-2.2.0-centos7.tar.gz --insecure "https://github.com/inspireso/docker/blob/master/nginx/tengine-2.2.0-centos7.tar.gz" 
$ tar xzf tengine-2.2.0-centos7.tar.gz -C /
$ systemctl enable nginx && systemctl start nginx.service
```

