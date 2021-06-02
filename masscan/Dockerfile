#
# A scanner built on masscan
#
# Only for simpler scans in docker for Windows. Not above rate=1000.

# Usage:
# docker run --rm \
# -v $(pwd):/data sdaaish/masscan:latest \
# -p0-1000 --rate=1000 -oB /data/cap.raw 10.10.10.1/32

FROM alpine:latest AS build
LABEL maintainer="sdaaish@charlottendal.net"

RUN apk add --update --no-cache \
    git make gcc musl-dev linux-headers && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src
RUN git clone --depth=1 https://github.com/robertdavidgraham/masscan.git masscan && \
    cd masscan && \
    make -j

FROM alpine:latest
RUN apk add --update --no-cache \
    libpcap-dev && \
    rm -rf /var/lib/apt/lists/*
COPY --from=build /src/masscan/bin/masscan /usr/local/bin/masscan

WORKDIR /data

ENTRYPOINT ["masscan"]
CMD ["--help"]
