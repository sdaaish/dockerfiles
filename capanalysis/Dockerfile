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
#VOLUME "/root/src"

#COPY ./cfg/01_nodoc /etc/dpkg/dpkg.cfg.d/

# Install packages
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone && \
    apt-get update && \
    apt-get install --yes --no-install-recommends \
    ca-certificates curl apt-utils gdebi php postgresql apache2 sudo whois netcat-openbsd

# Download the package
FROM base as src
RUN curl -o /root/capanalysis.deb "https://pilotfiber.dl.sourceforge.net/project/capanalysis/version%20${VERSION}/capanalysis_${VERSION}_amd64.deb"

# Install package and dependencies
COPY ./cfg/cleanup.sh /root/bin/cleanup.sh
FROM src as app
RUN gdebi --n /root/capanalysis.deb && \
    apt-get clean --yes && \
    apt-get autoremove --yes && \
    rm -f /root/capanalysis.deb && \
    bash -c /root/bin/cleanup.sh && \
    rm -rf /var/lib/apt/lists* && \
    echo '#!/bin/sh' > /usr/sbin/policy-rc.d && \
    echo 'exit 101' >> /usr/sbin/policy-rc.d && \
    chmod +x /usr/sbin/policy-rc.d && \
    sed -i -e 's/PRIORITY=1 #(0..20)/PRIORITY=0 #(0..20)Z/g' /etc/init.d/capanalysis

CMD service postgresql restart && \
    service apache2 restart && \
    service capanalysis restart && \
    tail -f /var/log/apache2/access.log
