  #
  # Mail Header Analyzer
  #
  # Source https://github.com/lnxg33k/email-header-analyzer.git src
  #
  # Run with:
  # docker run --rm \
  # sdaaish/mha -b 0.0.0.0 -p 8080

FROM alpine:latest AS build 
RUN apk add --update --no-cache \
    git && \
    git clone https://github.com/lnxg33k/email-header-analyzer.git /src

FROM alpine:latest
COPY --from=build /src /mha/
RUN apk add --update --no-cache \
    python3 \
    py3-pip \
    py3-yarl

WORKDIR /mha
RUN  pip install -r requirements.txt --no-cache-dir

ENTRYPOINT ["python3", "/mha/server.py"]
CMD ["--help"]
