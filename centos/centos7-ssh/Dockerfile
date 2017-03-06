FROM centos:7

MAINTAINER lan.xinen <lan.xinen@inspireso.cn>

RUN yum update -y \
  && yum install -y openssh  openssh-clients openssh-server \
  && echo 'root:root123' | chpasswd \
  && ssh-keygen -f /etc/s sh/ssh_host_rsa_key -N '' -t rsa \
  && ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa \
  && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
