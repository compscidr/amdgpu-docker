# amdgpu base image [![Build container](https://github.com/compscidr/amdgpu-docker/actions/workflows/build.yml/badge.svg)](https://github.com/compscidr/amdgpu-docker/actions/workflows/build.yml)
Docker base image to build simple GPU Compute Container. See the GH actions
workflows for current ubuntu version and driver versions which are supported.

## Build Container
Clone this Repository and type command in cloned directory. The build args
are option. If they are left out, the defaults are below.

```bash
docker build --build-arg UBUNTU_VERSION=20.04 --build-arg DRIVER_VERSION=21.30 -t <your image name to build> .
```

You can expand the container by add commands in Dockerfile, or use the image
in another container (build new container on top of this).

## Image on Dockerhub
Currently the images are tagged as follows:
`compscidr/amdgpu:UBUNTU_VERSION-DRIVER_VERSION`

https://hub.docker.com/r/compscidr/amdgpu

Based on https://github.com/BaileySN/Docker_AMDGPU_Base_Image buy updated to use a
more recent Ubuntu and AMD drivers.
