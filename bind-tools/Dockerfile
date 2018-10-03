# Run bind-tools in docker
# Usage:
# "docker run -it --rm bindtools dig linux.com"
FROM alpine
RUN apk update && apk add bind-tools
LABEL maintainer="sdaaish@charlottendal.net"
CMD ["dig","-h"]
