FROM alpine:3.3

MAINTAINER gloppasglop

RUN  apk --update add openjdk8-jre bash wget jq

RUN adduser -D -s /bin/false -u 1001 mc \
  && mkdir /data \
  && mkdir /config \
  && mkdir /mods \
  && mkdir /plugins \
  && chown mc:mc /data /config /mods /plugins

EXPOSE 25565

COPY mc.sh /mc.sh
ADD https://github.com/itzg/restify/releases/download/1.0.3/restify_linux_amd64 /restify
COPY mcadmin.jq /mcadmin.jq
RUN chmod +x /restify && chown mc:mc /restify


RUN chown mc:mc /mc.sh

USER mc

VOLUME ["/data"]
VOLUME ["/mods"]
VOLUME ["/config"]
VOLUME ["/plugins"]
COPY server.properties /tmp/server.properties
WORKDIR /data


# Special marker ENV used by MCCY management tool
ENV MC_IMAGE=YES

ENV UID=1001 GID=1001
ENV MOTD A Minecraft Server Powered by Docker
ENV JVM_OPTS -Xmx1024M -Xms1024M
ENV TYPE=VANILLA VERSION=LATEST FORGEVERSION=RECOMMENDED LEVEL=world PVP=true DIFFICULTY=easy \
  LEVEL_TYPE=DEFAULT GENERATOR_SETTINGS= WORLD= MODPACK=
ENTRYPOINT ["/mc.sh"]
CMD ["start"]
