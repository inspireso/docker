#!/usr/bin/env bash
$ images=(kube-proxy-amd64:v1.5.3 kube-controller-manager-amd64:v1.5.3  kube-scheduler-amd64:v1.5.3 kube-apiserver-amd64:v1.5.3 etcd-amd64:3.0.14-kubeadm  kube-discovery-amd64:1.0 pause-amd64:3.0)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName gcr.io/google_containers/$imageName
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
done