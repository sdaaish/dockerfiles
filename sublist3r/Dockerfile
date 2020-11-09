#
# Sublist3r
#
# Source: https://github.com/aboul3la/Sublist3r
#
# Run with:
# docker run --rm \
# sdaaish/sublist3r -d <domain-name>

FROM alpine:latest

RUN apk add --update --no-cache \
  python3 py3-pip

COPY src/ /app/
WORKDIR /app

RUN pip install -r requirements.txt --no-cache-dir

ENTRYPOINT ["python3", "./sublist3r.py"]
CMD ["--help"]
