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
RUN curl -o amdgpu.deb --referer https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-21-40-2 http://repo.radeon.com/amdgpu-install/21.40.2/ubuntu/focal/amdgpu-install_21.40.2.40502-1_all.deb && \
    DEBIAN_FRONTEND=noninteractive && apt install -y --no-install-recommends ./amdgpu.deb    
    #tar xf amdgpu.tar.xz --strip-components 1 && \
    #./amdgpu-install -y --opencl=rocr,legacy --headless --no-dkms && \
    #rm -rf /tmp/* && apt-get -y remove ca-certificates curl xz-utils initramfs-tools && \
    #apt-get clean autoclean && rm -rf /var/lib/{apt,dpkg,cache,log}

CMD ["/bin/bash"]
