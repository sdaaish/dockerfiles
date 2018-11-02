  #
  # Shodan CLI
  #
  # Run with:
  #  docker run --rm -it \
  #  -v ~/.shodan:/home/shodan/.shodan \
  #  shodan search <address>
 
FROM jfloff/alpine-python:3.cc6-slim

RUN pip install shodan --no-cache-dir \
  && addgroup shodan \
  && adduser -G shodan -D shodan

WORKDIR /home/shodan

USER shodan:shodan

ENTRYPOINT ["shodan"]
CMD ["--help"]
