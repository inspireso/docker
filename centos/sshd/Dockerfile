FROM centos:7

MAINTAINER lan.xinen <lan.xinen@inspireso.cn>

RUN yum update -y \
  && yum install -y openssh  openssh-clients openssh-server \
  && echo 'root:root123' | chpasswd \
  && ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
  && ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa \
  && ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519


EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
