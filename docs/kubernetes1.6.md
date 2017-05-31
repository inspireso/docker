# kubernetes1.6集群部署



## 环境

os: CentOS Linux release 7.3.1611 (Core)
kernel: Linux kuben0 3.10.0-514.2.2.el7.x86_64 #1 SMP Tue Dec 6 23:06:41 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

## 准备工作

```sh
#卸载防火墙
$ systemctl stop firewalld && sudo systemctl disable firewalld
$ yum remove -y firewalld

#内核参数设置
$ setenforce 0
$ echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
$ echo "net.bridge.bridge-nf-call-ip6tables = 1" >> /etc/sysctl.conf
$ echo "net.bridge.bridge-nf-call-iptables = 1" >> /etc/sysctl.conf
$ echo "net.netfilter.nf_conntrack_max=1000000" >> /etc/sysctl.conf
$ echo "vm.max_map_count = 262144" >> /etc/sysctl.conf
$ sysctl -p

#更改镜像为阿里镜像
$ mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
$ curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

#添加kubernetes镜像
$ cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
       https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
[docker]
name=Docker
baseurl=https://mirrors.aliyun.com/docker-engine/yum/repo/main/centos/7/
enabled=1
gpgcheck=0
repo_gpgcheck=0
EOF

#安装指定版本的docker-1.12.6
$ yum install -y yum-versionlock docker-engine-selinux-1.12.6-1.el7.centos.noarch docker-engine-1.12.6-1.el7.centos.x86_64 
$ yum versionlock add docker-engine-selinux docker-engine

#安装kubernetes组件
$ yum install -y  kubelet-1.6.3-0 kubectl-1.6.3-0 kubeadm-1.6.3-0 kubernetes-cni
$ systemctl enable docker && systemctl start docker
$ systemctl enable kubelet && systemctl start kubelet

# 配置镜像加速
$ tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": ["https://dqwotnqy.mirror.aliyuncs.com","http://095bbdcd.m.daocloud.io"]
}
EOF
#重启docker
$ systemctl restart docker
$ docker info

#配置docker日志自动归档
$ tee /etc/logrotate.d/docker <<-'EOF'
/var/lib/docker/containers/*/*.log
{
    size    50M
    rotate  0
    missingok
    nocreate
    #compress
    copytruncate
    nodelaycompress
    notifempty
}
EOF
```



## master

```sh
#下载镜像
$ kube_version=v1.6.4
$ images=(kube-proxy-amd64:$kube_version kube-scheduler-amd64:$kube_version kube-controller-manager-amd64:$kube_version kube-apiserver-amd64:$kube_version etcd-amd64:3.0.17  pause-amd64:3.0 k8s-dns-sidecar-amd64:1.14.1  k8s-dns-kube-dns-amd64:1.14.1 k8s-dns-dnsmasq-nanny-amd64:1.14.1)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName gcr.io/google_containers/$imageName
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
done

$ kubeadm init  --pod-network-cidr="10.1.0.0/16" --kubernetes-version=$kube_version

#配置网络CNI
#测试环境：直接使用weavenet
$ kubectl apply -f https://git.io/weave-kube-1.6

#生产环境: 使用calico
$ kubectl apply -f https://raw.githubusercontent.com/inspireso/docker/kubernetes/kubernetes/addon/calico/calico1.6.yaml

#安装dashboard
$ kubectl apply -f https://raw.githubusercontent.com/inspireso/docker/kubernetes/kubernetes/google_containers/kubernetes-dashboard1.6.yaml
```



## node

```sh
$ yum install -y nfs-utils

$ images=(kube-proxy-amd64:v1.6.4 pause-amd64:3.0)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName gcr.io/google_containers/$imageName
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
done

$ kubeadm join --token=xxxxxxxxxxxxx xxx.xxx.xxx.xxx
```



## FAQ

### networks have same bridge namer

 ```sh
 ip link del docker0 && rm -rf /var/docker/network/* && mkdir -p /var/docker/network/files
 systemctl start docker
 # delete all containers
 docker rm -f $(docker ps -a -q)
 ```

### master node->work load

```sh
$ kubectl taint nodes --all dedicated-
```



### node ->  unschedulable

```sh
$ kubectl taint nodes kuben0 dedicated=master:NoSchedule
```



### reset
```sh
$ kubeadm reset
$ rm /var/etcd/ -rf
$ docker rm -f $(docker ps -a -q)
```

### 升级linux内核

```sh
$ rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org \
&& rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm \
&& yum clean all \
&& yum --enablerepo=elrepo-kernel install kernel-ml \
&& grub2-set-default 0

# 查看
$ grub2-editenv list

#查看启动项
$ awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg

#查看已经安装的内核
$ rpm -qa | grep kernel
```

### OverlayFS

```sh
$ echo "overlay" > /etc/modules-load.d/overlay.conf
$ lsmod | grep overlay

$ sed -i -e '/^ExecStart=/ s/$/ --storage-driver=overlay/' /usr/lib/systemd/system/docker.service \
rm /var/lib/docker -rf
```

