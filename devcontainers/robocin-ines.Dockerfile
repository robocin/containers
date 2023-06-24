FROM robocin/cpp-ubuntu-latest:latest

COPY ./scripts/libzmq.sh /tmp/libzmq.sh
COPY ./scripts/cppzmq.sh /tmp/cppzmq.sh

RUN apt update --fix-missing
RUN apt install libprotobuf-dev libprotoc-dev protobuf-compiler -y
RUN apt install libboost-all-dev libmpfrc++-dev -y
RUN bash /tmp/libzmq.sh
RUN bash /tmp/cppzmq.sh
