FROM centos:7

MAINTAINER lan.xinen <lan.xinen@inspireso.cn>

RUN yum update -y \
  && yum install -y openssh  openssh-clients openssh-server \
  && echo 'root:root123' | chpasswd


EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
