# Run bind-tools in docker
# Usage:
# "docker run -it --rm sdaaish/bindtools dig linux.com"
FROM alpine:latest
LABEL maintainer="sdaaish@charlottendal.net"

RUN apk add --update --no-cache \
  bind-tools && \
  addgroup dig && adduser -h / -G dig -H -D dig

USER dig:dig
ENTRYPOINT ["dig"]
CMD ["-h"]
