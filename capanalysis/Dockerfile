# Under development

# Based on https://github.com/fjacquet/dockerfiles/blob/master/capanalysis/Dockerfile
FROM ubuntu:18.04 as base
LABEL maintainer="sdaaish@charlottendal.net"

ENV http_proxy ""
ENV ftp_proxy ""
ENV TZ=Europe/CET
ENV DEBIAN_FRONTEND noninteractive 

EXPOSE 9877
EXPOSE 30001

WORKDIR /root
VOLUME "/root/src"

# Install packages
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update && apt-get install --yes --no-install-recommends \
    ca-certificates curl apt-utils gdebi php postgresql apache2 sudo

# Download the package
FROM base as src
RUN curl -o capanalysis_1.2.3_amd64.deb "https://altushost-swe.dl.sourceforge.net/project/capanalysis/version%201.2.3/capanalysis_1.2.3_amd64.deb"

# Install package and dependencies
FROM src as app
RUN gdebi --n capanalysis_1.2.3_amd64.deb && \
    apt-get remove --yes curl gdebi apt-utils && \
    apt-get clean --yes && \ 
    rm -rf /var/lib/apt/lists*

RUN echo '#!/bin/sh' > /usr/sbin/policy-rc.d \
    && echo 'exit 101' >> /usr/sbin/policy-rc.d \
    && chmod +x /usr/sbin/policy-rc.d

RUN sed -i -e 's/PRIORITY=1 #(0..20)/PRIORITY=0 #(0..20)Z/g' /etc/init.d/capanalysis

CMD service postgresql restart && \
    service apache2 restart && \
    service capanalysis restart && \
    tail -f /var/log/apache2/access.log
