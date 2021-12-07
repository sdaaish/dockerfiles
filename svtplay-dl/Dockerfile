FROM ubuntu
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  gnupg \
  apt-transport-https \
  ffmpeg \
  rtmpdump

RUN curl -s https://svtplay-dl.se/release-key.txt | apt-key add - \
    && echo "deb https://apt.svtplay-dl.se/ svtplay-dl release" > /etc/apt/sources.list.d/svtplay-dl.list

RUN apt-get update && apt-get install -y --no-install-recommends \
  svtplay-dl \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /data

ENTRYPOINT ["/usr/bin/svtplay-dl"]
CMD ["--help"]
