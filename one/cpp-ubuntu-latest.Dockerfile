FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

LABEL one.project="multiple" \
      one.type="devcontainer" \
      one.environment="dogfood" \
      one.owner="robocin@cin.ufpe.br, jvsc@cin.ufpe.br, fnap@cin.ufpe.br" \
      one.version="1.0.1" \
      one.description="This image is RobôCIn's base image for developing \
      in linux latest version + cpp environments."

RUN apt update && apt upgrade -y

COPY ./scripts/robocin-install.sh /usr/local/bin/robocin-install
COPY ./scripts/robocin-user.sh /usr/local/bin/robocin-user

RUN robocin-install \
    cmake \
    ninja \
    python \
    g++ \
    grpc \
    googletest \
    benchmark \
    llvm

RUN robocin-user
USER robocin
