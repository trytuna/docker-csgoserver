FROM ubuntu:14.04
MAINTAINER Timo Schrappe <hello@timo.ruhr>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
    curl \
    lib32gcc1 \
    ca-certificates

RUN useradd -ms /bin/bash csgo
USER csgo
WORKDIR /home/csgo
RUN mkdir -p /home/csgo/data
RUN chown 1000:1000 /home/csgo/data
RUN curl -sqL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar zxvf -
COPY ./start-csgoserver.sh /usr/local/bin/start-csgoserver.sh

USER root
RUN chmod +x /usr/local/bin/start-csgoserver.sh

EXPOSE 27015/udp
EXPOSE 27015/tcp

USER csgo
CMD /usr/local/bin/start-csgoserver.sh
