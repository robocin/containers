FROM mcr.microsoft.com/devcontainers/go:1.23

LABEL one.project="multiple" \
      one.type="devcontainer" \
      one.environment="dogfood" \
      one.owner="robocin@cin.ufpe.br, jvsc@cin.ufpe.br, fnap@cin.ufpe.br" \
      one.version="1.0.0" \
      one.description="This image is RobôCIn's base image for developing \
      in linux vanilla + go + protobuf + grpc environments."

RUN set -x && \
    apt update && apt upgrade -y && \
    \
    apt install libsodium-dev libczmq-dev protobuf-compiler -y && \
    \
    : # last line

RUN set -x && \
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28 && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2 && \
    \
    : # last line
