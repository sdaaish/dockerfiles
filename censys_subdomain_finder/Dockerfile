#
# Censys Subdomain Finder
#
# Info: https://www.kitploit.com/2018/10/censys-subdomain-finder-perform.html?amp=0
# Source: https://github.com/christophetd/censys-subdomain-finder.git
#
# Run with:
# docker run --rm \
# -e CENSYS_API_ID=<api-id> \
# -e CENSYS_API_SECRET=<api_secret> \
# sdaaish/censys_subdomain_finder <domain-name>
 
FROM alpine:latest AS build
RUN apk add --update --no-cache \
    git && \
    git clone https://github.com/christophetd/censys-subdomain-finder.git /src

FROM alpine:latest
COPY --from=build src/ /app/
RUN apk add --update --no-cache \
    python3 \
    py3-pip

WORKDIR /app

RUN pip install -r requirements.txt --no-cache-dir

ENTRYPOINT ["python3", "./censys_subdomain_finder.py"]
CMD ["--help"]
