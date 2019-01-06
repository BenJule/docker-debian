#
# Debian Dockerfile
#

# Pull base image.
FROM debian:buster

MAINTAINER BenLue <benlue@s3root.ovh>
ENV DEBIAN_FRONTEND noninteractive

# System Update.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get clean

# build tools
RUN apt-get update && apt-get -y --no-install-recommends install \
    openjdk-8-jdk \
    python \
    bc \
    yasm \
    rsync \
    schedtool \
    imagemagick \
    git-core \
    gnupg \
    flex \
    bison \
    gperf \
    build-essential \
    zip \
    curl \
    zlib1g-dev \
    gcc-multilib \
    g++-multilib \
    libc6-dev-i386 \
    lib32ncurses5-dev \
    x11proto-core-dev \
    libx11-dev \
    lib32z-dev \
    libssl-dev \
    ccache \
    libgl1-mesa-dev \
    libxml2-utils \
    xsltproc \
    unzip \
    openssh-client && \
    apt-get clean
#    rm -rf /var/lib/apt/lists/* && \
#    rm -rf /tmp/* && \
#    rm -rf /var/tmp/*

# Add user
RUN useradd -ms /bin/bash benlue

# Add folder
RUN mkdir -p /home/benlue/shared

# Add files.
ADD shared/install_repo.sh /home/benlue/shared/install_repo.sh
ADD shared/sync_lineage-16.0.sh /home/benlue/shared/sync_lineage-16.0.sh

# Set environment variables.
ENV HOME /home/benlue

# Define working directory.
WORKDIR /home/benlue

# Define default command.
CMD ["bash"]
