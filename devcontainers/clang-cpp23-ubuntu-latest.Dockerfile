FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

RUN apt update && apt upgrade -y

ARG GITHUB_SOURCE_CONTENT_PREFIX="https://raw.githubusercontent.com/robocin/scripts-ubuntu-common/main"

RUN bash -c "$(wget -O - $GITHUB_SOURCE_CONTENT_PREFIX/llvm.sh)"

ARG VERSION=3.28.0-rc4

ADD https://github.com/Kitware/CMake/releases/download/v$VERSION/cmake-$VERSION.tar.gz /tmp/cmake.tar.gz

RUN tar -zxvf /tmp/cmake.tar.gz -C /tmp/ && \
  cd /tmp/cmake-$VERSION && \
  ./bootstrap && \
  make && \
  make install && \
  rm -rf /tmp/cmake-$VERSION /tmp/cmake.tar.gz

ADD https://github.com/ninja-build/ninja/releases/download/v1.11.1/ninja-linux.zip /tmp/ninja.zip

RUN unzip /tmp/ninja.zip -d /tmp/ && \
  mv /tmp/ninja /usr/bin/ && \
  rm -rf /tmp/ninja /tmp/ninja.zip
