# Disclaimer:
# This is a dump study Dockerfile even tho it needs to have all modules
# (rcssmonitor, rcssserver, simulation-2d-librcsc) downloaded in the current directory to build itself.


# Pull base image.
FROM robocin/cpp-ubuntu-20.04:latest

# packages setup
RUN apt update

# Setup tzdata
RUN \ 
  apt-get install -yq tzdata && \
  ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata

# Needed packages
RUN apt install -yq \
  git build-essential automake autoconf libtool flex bison libboost-all-dev \
  qt5-default libfontconfig1-dev libaudio-dev libxt-dev libglib2.0-dev libxi-dev libxrender-dev

# rcssserver install
WORKDIR /root
RUN git clone https://github.com/rcsoccersim/rcssserver.git
RUN \
  cd rcssserver && ./bootstrap && ./configure && \
  make && make install && \
  cd /root && rm -rf rcssserver

# rcssmonitor install
WORKDIR /root
RUN git clone https://github.com/rcsoccersim/rcssmonitor.git
RUN \
  cd rcssmonitor && ./bootstrap && ./configure && \
  make && make install && \
  cd /root && rm -rf rcssmonitor

# Set environment variables.
ENV HOME /root
ENV DISPLAY :0

# Define working directory.
WORKDIR /root

RUN apt install -yq x11-apps

# Define default command.
CMD ["bash"]