# Run bind-tools in docker
# Usage:
# "docker run -it --rm sdaaish/bindtools dig linux.com"
FROM alpine
LABEL maintainer="sdaaish@charlottendal.net"

RUN apk update && apk add bind-tools \
  && addgroup dig && adduser -h / -G dig -H -D dig

USER dig:dig
CMD ["dig","-h"]
