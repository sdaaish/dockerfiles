# Run mtr in docker
# Usage:
# "docker run -it --rm sdaaish/mtr"
FROM alpine
LABEL maintainer="sdaaish@charlottendal.net"

RUN apk update && apk add mtr

ENTRYPOINT ["mtr"]
CMD ["-h"]
