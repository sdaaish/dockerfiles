# Under development

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
    apt-utils \
    gdebi \
    php \
    postgresql \
    apache2 \
    sudo \
    whois \
    netcat-openbsd

# Download the package
FROM base as src
RUN curl -o /root/capanalysis.deb "https://pilotfiber.dl.sourceforge.net/project/capanalysis/version%20${VERSION}/capanalysis_${VERSION}_amd64.deb"

# Install package and dependencies
FROM src as app
COPY ./cfg/cleanup.sh /root/bin/cleanup.sh
RUN gdebi --n /root/capanalysis.deb && \
    apt-get clean --yes && \
    apt-get autoremove --yes && \
    rm -f /root/capanalysis.deb && \
    bash -c /root/bin/cleanup.sh && \
    rm -rf /var/lib/apt/lists*

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["restart"]
