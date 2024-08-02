FROM ubuntu:latest

RUN apt-get update -y && apt-get install -y sudo adduser

RUN useradd -m test && echo "test:test" | chpasswd && adduser test sudo

COPY . /home/test/

RUN chown -R test:test /home/test/

USER test

WORKDIR /home/test/

ENTRYPOINT ["/usr/bin/bash"]