# centos7 + lvs + keepalived

## install lvs, keepalived

```sh
$ mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
$ yum install -y ipvsadm keepalived
```

## config

```sh
vi /etc/keepalived/keepalived.conf


```



nginx

```sh
$ yum install net-tools

$ echo <<EOF > /etc/init.d/real.sh
#!/bin/bash

VIP=192.168.3.66

/etc/rc.d/init.d/functions

case "$1" in
  start)
      ifconfig lo:0 $VIP netmask 255.255.255.255 broadcast $VIP
      /sbin/route add -host $VIP dev lo:0
      echo "1" >/proc/sys/net/ipv4/conf/lo/arp_ignore
      echo "2" >/proc/sys/net/ipv4/conf/lo/arp_announce
      echo "1" >/proc/sys/net/ipv4/conf/all/arp_ignore
      echo "2" >/proc/sys/net/ipv4/conf/all/arp_announce
      sysctl -p >/dev/null 2>&1
      echo "RealServer Start OK"
      ;;
  stop)
      ifconfig lo:0 down
      route del $VIP >/dev/null 2>&1
      echo "0" >/proc/sys/net/ipv4/conf/lo/arp_ignore
      echo "0" >/proc/sys/net/ipv4/conf/lo/arp_announce
      echo "0" >/proc/sys/net/ipv4/conf/all/arp_ignore
      echo "0" >/proc/sys/net/ipv4/conf/all/arp_announce
      echo "RealServer Stoped"
      ;;
  *)
      echo "Usage: $0 {start|stop}"
      exit 1
esac

exit 0
EOF

$ chmod +x /etc/init.d/real.sh
$ /etc/init.d/real.sh start

```

