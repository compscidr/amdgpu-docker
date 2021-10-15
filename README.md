# Docker_AMDGPU_Base_Image
Docker base image to build simple GPU Compute Container

# Build Container
Clone this Repositority and type command in cloned directory.

```bash
docker build -t <your image name to build> .
```

You can expand the container by add commands in Dockerfile, or use the image
in another container (build new container on top of this).

# Image on Dockerhub
https://hub.docker.com/r/compscidr/amdgpu

Based on https://github.com/BaileySN/Docker_AMDGPU_Base_Image buy updated to use a
more recent Ubuntu and AMD drivers.
