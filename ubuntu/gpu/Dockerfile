FROM nvidia/cuda:11.0-base

RUN mv /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/cuda.list.bak; \
    apt update && apt install -y \
    gettext-base \
    initramfs-tools \
    apt-utils \
    unzip \
    tar \
    curl \
    wget \
    xz-utils \
    ocl-icd-libopencl1 \
    opencl-headers \
    clinfo \
    ; \
    apt autoremove && rm -rf /var/lib/apt/lists/*;

ARG AMD_DRIVER=amdgpu-pro-21.20-1271047-ubuntu-20.04.tar.xz
ARG AMD_DRIVER_URL=https://drivers.amd.com/drivers/linux
RUN mkdir -p /tmp/opencl-driver-amd && cd /tmp/opencl-driver-amd; \
    curl --referer $AMD_DRIVER_URL -O $AMD_DRIVER_URL/$AMD_DRIVER; \
    tar -Jxvf $AMD_DRIVER; \
    cd amdgpu-pro-*; \
    ./amdgpu-install --opencl=legacy,rocr --headless --no-dkms -y; \
    rm -rf /tmp/opencl-driver-amd; \
    mkdir -p /etc/OpenCL/vendors && echo "libamdocl64.so" > /etc/OpenCL/vendors/amdocl64.icd; \
    ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /usr/lib/libOpenCL.so;

