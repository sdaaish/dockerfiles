FROM ubuntu
RUN apt-get update && apt-get install -y \
curl \
apt-transport-https \
ffmpeg \
rtmpdump
RUN curl -s https://svtplay-dl.se/release-key.txt | apt-key add - \
&& echo "deb https://apt.svtplay-dl.se/ svtplay-dl release" > /etc/apt/sources.list.d/svtplay-dl.list
RUN apt-get update && apt-get install svtplay-dl -y \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /data

ENTRYPOINT ["/usr/bin/svtplay-dl"]
