FROM robocin/cpp-ubuntu-latest:latest

RUN apt update --fix-missing

COPY ./scripts/protoc.sh /tmp/protoc.sh
COPY ./scripts/libzmq.sh /tmp/libzmq.sh
COPY ./scripts/cppzmq.sh /tmp/cppzmq.sh

RUN bash /tmp/protoc.sh
RUN bash /tmp/libzmq.sh
RUN bash /tmp/cppzmq.sh

RUN apt install libboost-all-dev libmpfrc++-dev -y
RUN pip3 install --upgrade pip
RUN pip3 install netifaces
RUN pip3 install pyzmq
RUN pip3 install protobuf