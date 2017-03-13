#!/usr/bin/env bash

images=(kube-proxy-amd64 kube-controller-manager-amd64  kube-scheduler-amd64 kube-apiserver-amd64)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName:latest
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName:latest gcr.io/google_containers/$imageName:v1.5.3
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName:latest
done

images=(etcd-amd64:3.0.14-kubeadm  kube-discovery-amd64:1.0 pause-amd64:3.0 etcd:2.2.1)
for imageName in ${images[@]} ; do
  docker pull registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
  docker tag registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName gcr.io/google_containers/$imageName
  docker rmi registry.cn-hangzhou.aliyuncs.com/kube_containers/$imageName
done