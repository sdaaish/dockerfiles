FROM ubuntu:24.04 AS build

RUN apt-get update && \
    apt-get install --yes \
    libemail-outlook-message-perl \
    libemail-localdelivery-perl && \
    useradd -U msg

FROM build
COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod 0555 /usr/local/bin/*
USER msg
WORKDIR /home/msg

ENTRYPOINT ["docker-entrypoint.sh"]
