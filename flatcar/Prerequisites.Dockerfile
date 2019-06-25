FROM ubuntu:xenial
#  -no-install-recommends
RUN  apt-get update \
        && apt-get install -y linux-virtual-lts-xenial linux-tools-virtual-lts-xenial linux-cloud-tools-virtual-lts-xenial \
        && rm -rf /var/lib/apt/lists/*
        