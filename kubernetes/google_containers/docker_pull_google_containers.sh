#!/usr/bin/env bash

kube_version=v1.6.0
#master
images=(kube-proxy-amd64 kube-controller-manager-amd64  kube-scheduler-amd64 kube-apiserver-amd64)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName:$kube_version
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName:$kube_version gcr.io/google_containers/$imageName:$kube_version
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName:$kube_version
done

#master
images=(etcd-amd64:3.0.17  pause-amd64:3.0 k8s-dns-sidecar-amd64:1.14.1  k8s-dns-kube-dns-amd64:1.14.1 k8s-dns-dnsmasq-nanny-amd64:1.14.1)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName gcr.io/google_containers/$imageName
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
done


#node
images=(kube-proxy-amd64:v1.5.3 pause-amd64:3.0)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName gcr.io/google_containers/$imageName
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
done
