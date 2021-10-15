FROM ubuntu:20.04

LABEL maintainer="Jason Ernst"
LABEL description="Ubuntu with AMD graphic support"

WORKDIR /tmp
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get -y dist-upgrade  && \
    apt-get -y --no-install-recommends install ca-certificates curl xz-utils initramfs-tools

# since we can't use curl directly to the amd website
# https://gist.github.com/kytulendu/3351b5d0b4f947e19df36b1ea3c95cbe
# https://linuxhandbook.com/setup-opencl-linux-docker/
RUN curl -o amdgpu.tar.xz --referer https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-21-30 https://drivers.amd.com/drivers/linux/amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz && \
    tar xf amdgpu.tar.xz --strip-components 1 && \
    ./amdgpu-install -y --opencl=rocr,legacy --headless --no-dkms && \
    rm -rf /tmp/* && apt-get -y remove ca-certificates curl xz-utils initramfs-tools && \
    apt-get clean autoclean && rm -rf /var/lib/{apt,dpkg,cache,log}

CMD ["/bin/bash"]
