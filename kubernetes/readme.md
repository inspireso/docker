Your Kubernetes master has initialized successfully!

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
[http://kubernetes.io/docs/admin/addons/](http://kubernetes.io/docs/admin/addons/)

You can now join any number of machines by running the following on each node:


## prepare

```sh
#卸载防火墙
$ sudo systemctl stop firewalld
$ sudo systemctl disable firewalld
$ sudo yum remove -y firewalld

#内核参数设置
$ sudo setenforce 0 && sysctl -w vm.max_map_count=262144

#更改镜像为阿里镜像
$ sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
$ sudo curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

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
$ setenforce 0

#安装指定版本的docker
$ yum install -y docker-engine-selinux-1.12.5-1.el7.centos.noarch docker-engine-1.12.5-1.el7.centos.x86_64 
$ sudo yum install -y kubelet kubeadm kubectl kubernetes-cni
$ sudo systemctl enable docker && systemctl start docker
$ sudo systemctl enable kubelet && systemctl start kubelet

# 配置镜像加速
$ sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": ["https://dqwotnqy.mirror.aliyuncs.com","http://095bbdcd.m.daocloud.io"]
}
EOF
#重启docker
$ sudo systemctl restart docker
$ docker info

#配置docker日志自动归档
$ sudo tee /etc/logrotate.d/docker <<-'EOF'
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
$ kube_version=v1.5.1
$ images=(kube-proxy-amd64:$kube_version kube-scheduler-amd64:$kube_version kube-controller-manager-amd64:$kube_version kube-apiserver-amd64:$kube_version etcd-amd64:3.0.14-kubeadm kube-dnsmasq-amd64:1.4 exechealthz-amd64:1.2 pause-amd64:3.0 dnsmasq-metrics-amd64:1.0 kube-discovery-amd64:1.0 kubedns-amd64:1.9)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName gcr.io/google_containers/$imageName
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
done

$ kubeadm init  --use-kubernetes-version $kube_version

#配置网络
#测试：直接使用weavenet
$ kubectl apply -f https://git.io/weave-kube

#生产: 使用calico
$ kubectl apply -f https://raw.githubusercontent.com/inspireso/docker/kubernetes/kubernetes/addon/calico/calico.yaml

$ kubectl apply -f https://raw.githubusercontent.com/inspireso/docker/kubernetes/kubernetes/google_containers/kubernetes-dashboard.yaml
```





## node

```sh
$ nfs-utils

$ images=(kube-proxy-amd64:v1.5.1 pause-amd64:3.0)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName gcr.io/google_containers/$imageName
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
done

$ kubeadm join --token=xxxxxxxxxxxxx xxx.xxx.xxx.xxx
```



## FAQ

###networks have same bridge name

> ```sh
> ip link del docker0 && rm -rf /var/docker/network/* && mkdir -p /var/docker/network/files
> systemctl start docker
> # delete all containers
> docker ps -a | cut -d' ' -f 1 | xargs -n 1 echo docker rm  -f
> ```

### master node->work load

>```sh
>$ kubectl taint nodes --all dedicated-
>```



### node ->  unschedulable

>```sh
>$ kubectl taint nodes kuben0 dedicated=master:NoSchedule
>```

