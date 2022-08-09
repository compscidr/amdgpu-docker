#!/bin/bash
if [ -n $UBUNTU_VERSION ]
then
  if [ -n $DRIVER_VERSION ]
  then
    if [ $DRIVER_VERSION == "21.30" ]
    then
      if [ $UBUNTU_VERSION == "20.04" ]
      then
        dpkg --add-architecture i386
        apt-get update && apt-get -y dist-upgrade  && \
        apt-get -y --no-install-recommends install ca-certificates curl xz-utils initramfs-tools

        curl -o amdgpu.tar.xz --referer https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-21-30 https://drivers.amd.com/drivers/linux/amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz
        tar xf amdgpu.tar.xz --strip-components 1

        ./amdgpu-install -y --opencl=rocr,legacy --headless --no-dkms
        rm -rf /tmp/*
        apt-get -y remove ca-certificates curl xz-utils initramfs-tools
        apt-get clean autoclean && rm -rf /var/lib/{apt,dpkg,cache,log}
        
        exit
      else
        echo -e "UBUNTU_VERSION $UBUNTU_VERSION not supported with DRIVER_VERSION $DRIVER_VERSION"
        exit
      fi
    elif [ $DRIVER_VERSION == "22.20" ]
    then
      if [ $UBUNTU_VERSION == "20.04" ]
      then
        curl -o amdgpu.deb --referer https://www.amd.com/en/support/graphics/radeon-500-series/radeon-rx-500x-series/radeon-rx-580x https://repo.radeon.com/amdgpu-install/22.20/ubuntu/focal/amdgpu-install_22.20.50200-1_all.deb && \
          dpkg -i amdgpu.deb
      elif [ $UBUNTU_VERSION == "22.04" ]
      then
        curl -o amdgpu.deb --referer https://www.amd.com/en/support/graphics/radeon-500-series/radeon-rx-500x-series/radeon-rx-580x https://repo.radeon.com/amdgpu-install/22.20/ubuntu/jammy/amdgpu-install_22.20.50200-1_all.deb && \
          dpkg -i amdgpu.deb
      else
        echo -e "NO SUPPORT FOR UBUNTU_VERSION $UBUNTU_VERSION and DRIVER_VERSION $DRIVER_VERSION"
        exit
      fi
    else
      echo -e "DRIVER_VERSION $DRIVER_VERSION not supported"
      exit
    fi
  else
    echo -e "DRIVER_VERSION not set"
  fi
else
  echo -e "UBUNTU_VERSION not set"
fi
