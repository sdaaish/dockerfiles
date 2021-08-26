FROM ubuntu:18.04 AS build

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
    libemail-outlook-message-perl \
    libemail-sender-perl && \
    useradd -U msg

FROM build
COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod 0555 /usr/local/bin/*
USER msg
WORKDIR /home/msg

ENTRYPOINT ["docker-entrypoint.sh"]
