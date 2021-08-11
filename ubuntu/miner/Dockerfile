FROM registry.cn-hangzhou.aliyuncs.com/base_containers/gpu:cuda-opencl

RUN mkdir -p /miners/gminer && cd /miners/ \
&& wget https://github.com/develsoftware/GMinerRelease/releases/download/2.63/gminer_2_63_linux64.tar.xz \
&& tar -xvf gminer_2_63_linux64.tar.xz -C /miners/gminer/ \
&& rm -f gminer_2_63_linux64.tar.xz 

RUN mkdir -p /miners/teamredminer && cd /miners/ \
&& wget https://github.com/todxx/teamredminer/releases/download/v0.8.4/teamredminer-v0.8.4-linux.tgz \
&& tar -xvf teamredminer-v0.8.4-linux.tgz \
&& mv /miners/teamredminer-v0.8.4-linux /miners/teamredminer \
&& rm -f teamredminer-v0.8.4-linux.tgz


