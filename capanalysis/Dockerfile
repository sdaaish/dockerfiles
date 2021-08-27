#
# CapAnalysis
#
# Source: https://github.com/xplico/CapAnalysis
#
# A docker image for capanalysis
# Run with:
# docker run --rm \
#  -p 9877:9877 sdaaish/capanalysis:latest

# Based on https://github.com/fjacquet/dockerfiles/blob/master/capanalysis/Dockerfile
FROM ubuntu:18.04 as base
LABEL maintainer="sdaaish@charlottendal.net"

ENV http_proxy=""
ENV ftp_proxy=""
ENV TZ="Europe/CET"
ENV VERSION="1.2.3"
ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 9877
EXPOSE 30001

WORKDIR /root

#COPY ./cfg/01_nodoc /etc/dpkg/dpkg.cfg.d/

# Install packages
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    printf "${TZ}\n" > /etc/timezone && \
    apt-get update && \
    apt-get install --yes --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    apt-utils \
    php \
    postgresql \
    apache2 \
    sudo \
    whois \
    netcat-openbsd \
    libgeoip1 \
    libpcap0.8 \
    libpq5 \
    libssl1.1 \
    zlib1g \
    tshark \
    samba \
    apache2 \
    php-common \
    libapache2-mod-php \
    php-sqlite3 \
    php-pgsql \
    php-cli \
    sqlite3 \
    openssl \
    postgresql \
    postgresql-client \
    php-mdb2-driver-pgsql \
    tar \
    php-json \
    libgeoip-dev \
    libndpi-dev \
    libjson-c-dev \
    zip \
    unzip

# Download the package
FROM base as src
RUN curl -o /root/capanalysis.deb "https://pilotfiber.dl.sourceforge.net/project/capanalysis/version%20${VERSION}/capanalysis_${VERSION}_amd64.deb"

# Install package and dependencies
FROM src as app
COPY ./cfg/cleanup.sh /root/bin/cleanup.sh
RUN dpkg --install /root/capanalysis.deb && \
    apt-get --fix-broken install --yes && \
    apt-get clean --yes && \
    apt-get autoremove --yes && \
    rm -f /root/capanalysis.deb && \
    chmod a+x /root/bin/* && \
    bash -c /root/bin/cleanup.sh && \
    rm -rf /var/lib/apt/lists*

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["restart"]
