ARG UBUNTU_VERSION=20.04
ARG DRIVER_VERSION=21.30
FROM ubuntu:$UBUNTU_VERSION
ARG UBUNTU_VERSION
ARG DRIVER_VERSION

ENV DRIVER_VERSION=${DRIVER_VERSION}
ENV UBUNTU_VERSION=${UBUNTU_VERSION}

LABEL maintainer="Jason Ernst"
LABEL description="Ubuntu with AMD graphic support"

WORKDIR /tmp

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 ca-certificates curl

COPY ./install_driver.sh .
RUN chmod +x install_driver.sh && ./install_driver.sh

CMD ["/bin/bash"]
