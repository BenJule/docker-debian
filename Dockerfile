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

# Add files
ADD tools/.profile /home/benlue/.profile 
#RUN home/benlue/.profile 
RUN mkdir -p /usr/local/bin/
RUN chmod 755 /usr/local/bin/*


# Install repo cli
#RUN curl https://storage.googleapis.com/git-repo-downloads/repo > home/benlue/bin/repo \
ADD https://commondatastorage.googleapis.com/git-repo-downloads/repo /usr/local/bin/ \
    chmod a+x home/benlue/bin/repo

# Add folder
RUN mkdir -p /home/benlue/workspace

# Fetch lineage
RUN mkdir -p /home/benlue/workspace/lineage-16.0 && cd /home/benlue/lineage-16.0 \
    repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-16.0 \
    repo sync -f --force-sync --force-broken --no-clone-bundle --no-tags -j2

# Set environment variables.
ENV HOME /home/benlue

# Define working directory.
WORKDIR /home/benlue

# Define default command.
CMD ["bash"]
