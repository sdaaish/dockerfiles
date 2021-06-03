#
# Sublist3r
#
# Source: https://github.com/aboul3la/Sublist3r
#
# Run with:
# docker run --rm \
# sdaaish/sublist3r -d <domain-name>

FROM alpine:latest AS build 
RUN apk add --update --no-cache \
    git && \
    git clone https://github.com/aboul3la/Sublist3r.git /src

FROM alpine:latest
COPY --from=build src/ /app/
RUN apk add --update --no-cache \
    python3 \
    py3-pip

WORKDIR /app

RUN pip install -r requirements.txt --no-cache-dir

ENTRYPOINT ["python3", "./sublist3r.py"]
CMD ["--help"]
