FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

RUN apt update && apt upgrade -y

COPY ./scripts/robocin-install.sh /usr/local/bin/robocin-install

RUN robocin-install \
    cmake \
    ninja \
    python \
    g++ \
    grpc \
    googletest \
    benchmark \
    llvm