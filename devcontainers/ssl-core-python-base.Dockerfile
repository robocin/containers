FROM mcr.microsoft.com/vscode/devcontainers/python:3

ARG PROTOC_VERSION='25.3'

COPY devcontainers/scripts /tmp/scripts
WORKDIR /tmp/scripts

RUN apt update && apt upgrade -y && \
  bash protoc.sh ${PROTOC_VERSION} '/usr/local'

RUN rm -rf /tmp/scripts
