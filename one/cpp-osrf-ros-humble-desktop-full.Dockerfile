FROM osrf/ros:humble-desktop-full

LABEL one.project="multiple" \
      one.type="devcontainer" \
      one.environment="dogfood" \
      one.owner="robocin@cin.ufpe.br, fnap@cin.ufpe.br" \
      one.version="1.0.0" \
      one.description="This image is RobôCIn's base image for developing \
      in linux vanilla + cpp + ros2 in ui-dependent environments."

RUN apt update && apt upgrade -y

RUN apt-get install wget -y

COPY ./scripts/robocin-install.sh /usr/local/bin/robocin-install

RUN robocin-install \
    cmake \
    ninja \
    g++ \
    googletest \
    llvm \
    clang-format