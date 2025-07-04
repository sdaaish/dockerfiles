#
# Sublist3r
#
# Source: https://github.com/aboul3la/Sublist3r
#
# Run with:
# docker run --rm \
# sdaaish/sublist3r -d <domain-name>

FROM alpine:latest AS build
ENV PATH=/root/.local/bin:$PATH
COPY local-path.sh /etc/profile.d/
RUN apk add --update --no-cache uv && \
    uv tool install --python 3.10 sublist3r

WORKDIR /app

ENTRYPOINT ["sublist3r"]
CMD ["--help"]
