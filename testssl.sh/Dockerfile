#
# testssl.sh
#
# Source https://github.com/drwetter/testssl.sh
#
# Run with:
# docker run --rm \
# sdaaish/testssl.sh <domainname>
#
# or
#
# docker run --rm \
# -v $(pwd)/input:/home/testssl/input \
# -v $(pwd)/reports:/home/testssl/reports \
# testssl.sh --file input/infile

FROM alpine:latest AS build
RUN apk add --update --no-cache \
    git && \
    git clone --depth=1 https://github.com/drwetter/testssl.sh.git /src

FROM alpine:latest
COPY --from=build /src /home/testssl/
RUN apk add --update --no-cache \
    bash procps drill coreutils curl

RUN addgroup testssl && \
  adduser -G testssl -g "testssl user"  -s /bin/bash -D testssl && \
  ln -s /home/testssl/testssl.sh /usr/local/bin/

USER testssl
WORKDIR /home/testssl/

ENTRYPOINT ["testssl.sh"]
CMD ["--help"]
