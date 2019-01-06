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
RUN useradd -ms /bin/bash android

# Add folder
RUN mkdir -p /home/android/bin
RUN mkdir -p /home/android/workspace


# Install repo cli
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /home/android/bin/repo \
    chmod a+x /home/android/bin/repo \
    chown -R android:android /home/android

# Fetch lineage
RUN mkdir -p /home/android/workspace/lineage-16.0 && cd /home/android/workspace/lineage-16.0 \
    repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-16.0 \
    repo sync -f --force-sync --force-broken --no-clone-bundle --no-tags -j2

# Set environment variables.
ENV HOME /home/android

# Define working directory.
WORKDIR /home/android

# Define default command.
CMD ["bash"]
