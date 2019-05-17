  #
  # Mail Header Analyzer
  #
  # Source https://github.com/lnxg33k/email-header-analyzer.git src
  #
  # Run with:
  # docker run --rm \
  # sdaaish/mha -b 0.0.0.0 -p 8080

FROM alpine:latest

RUN apk update && \
  apk upgrade && \
  apk add python py2-pip

COPY src/ /mha/
RUN  pip install -r /mha/requirements.txt --no-cache-dir

WORKDIR /mha
EXPOSE 8080

ENTRYPOINT ["python", "/mha/server.py"]
CMD ["--help"]
