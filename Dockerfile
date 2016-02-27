FROM alpine:3.3

MAINTAINER gloppasglop

RUN  apk --update add openjdk8-jre bash wget jq

RUN adduser -D -s /bin/false -u 1000 mc \
  && mkdir /data \
  && mkdir /config \
  && mkdir /mods \
  && mkdir /plugins \
  && chown mc:mc /data /config /mods /plugins

EXPOSE 25565

COPY start-minecraft.sh /start-minecraft

RUN chown mc:mc /start-minecraft

USER mc

VOLUME ["/data"]
VOLUME ["/mods"]
VOLUME ["/config"]
VOLUME ["/plugins"]
COPY server.properties /tmp/server.properties
WORKDIR /data

CMD [ "/start-minecraft" ]

# Special marker ENV used by MCCY management tool
ENV MC_IMAGE=YES

ENV UID=1000 GID=1000
ENV MOTD A Minecraft Server Powered by Docker
ENV JVM_OPTS -Xmx1024M -Xms1024M
ENV TYPE=VANILLA VERSION=LATEST FORGEVERSION=RECOMMENDED LEVEL=world PVP=true DIFFICULTY=easy \
  LEVEL_TYPE=DEFAULT GENERATOR_SETTINGS= WORLD= MODPACK=
