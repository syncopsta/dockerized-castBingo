FROM adoptopenjdk:8u282-b08-jre-hotspot
LABEL org.opencontainers.image.authors="Syncopsta <dockerhub@syncopsta.de>"
RUN apt update
RUN apt install unzip python3 lsof bash curl wget git sudo -y
RUN mkdir -m 777 /data
EXPOSE 25565 25575
RUN wget https://github.com/MelanX/castBINGO/releases/download/v1.1.5/server-1.1.5.zip
RUN mv server-1.1.5.zip /data
WORKDIR /data
RUN unzip /data/server-1.1.5.zip
RUN echo "max-tick-time=-1" >> /data/server.properties
RUN rm setup_server.py
RUN wget https://raw.githubusercontent.com/MelanX/castBINGO/master/serverdata/setup_server.py
RUN python3 setup_server.py
WORKDIR /data/mods
RUN wget https://media.forgecdn.net/files/3093/467/jmt_mcmt-1.16.3-0.18.60.jar
RUN mkdir /data/config
COPY config/performant-common.toml /data/config/
WORKDIR /data
ENTRYPOINT [ "java", "-jar", "forge.jar" ]
