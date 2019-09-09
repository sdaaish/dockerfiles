#
# Sublist3r
#
# Source: https://github.com/aboul3la/Sublist3r
#
# Run with:
# docker run --rm \
# sdaaish/sublist3r -d <domain-name>

FROM alpine:latest

RUN apk update && \
  apk upgrade && \
  apk add python py2-pip

COPY src/ /app/
WORKDIR /app

RUN pip install -r requirements.txt --no-cache-dir

ENTRYPOINT ["python", "./sublist3r.py"]
CMD ["--help"]
