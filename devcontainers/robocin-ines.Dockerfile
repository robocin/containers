FROM robocin/cpp-ubuntu-latest:latest

COPY ./scripts/libzmq.sh /tmp/libzmq.sh
COPY ./scripts/cppzmq.sh /tmp/cppzmq.sh

RUN bash /tmp/libzmq.sh
RUN bash /tmp/cppzmq.sh
