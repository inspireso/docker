#!/usr/bin/env bash

images=(kube-discovery-amd64:1.0 kubedns-amd64:1.9 etcd-amd64:3.0.14-kubeadm kube-dnsmasq-amd64:1.4 exechealthz-amd64:1.2 pause-amd64:3.0 dnsmasq-metrics-amd64:1.0)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/latest gcr.io/google_containers/$imageName
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
done

images=(kube-proxy-amd64 kube-scheduler-amd64 kube-controller-manager-amd64 kube-apiserver-amd64)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName:latest
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName:latest gcr.io/google_containers/$imageName:v1.5.3
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName:latest
done