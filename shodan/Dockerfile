#
# Shodan CLI
#
# Run with:
#  docker run --rm -it \
#  -v ~/.shodan:/home/shodan/.shodan \
#  shodan search <address>
 
FROM alpine:latest

RUN apk add --update --no-cache \
  python3 py3-pip && \
  pip install shodan --no-cache-dir && \
  addgroup shodan && \
  adduser -G shodan -D shodan

WORKDIR /home/shodan
USER shodan:shodan

ENTRYPOINT ["shodan"]
CMD ["--help"]
