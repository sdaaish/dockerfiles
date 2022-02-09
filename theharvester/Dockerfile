FROM alpine:latest AS source
RUN apk add --update --no-cache \
    git && \
    git clone https://github.com/laramies/theHarvester.git /src

FROM ubuntu:hirsute AS build
RUN mkdir /app
WORKDIR /app
COPY --from=source src/ /app
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -qy python3 python3-pip libffi-dev libxml2-dev libxslt1-dev && /usr/bin/python3 -m pip install --upgrade pip && apt clean && apt autoremove -qy
RUN /usr/bin/python3 --version && pip3 install --no-cache-dir -r requirements.txt && chmod +x ./*.py
ENTRYPOINT ["/app/theHarvester.py"]
ENTRYPOINT ["/app/restfulHarvest.py -H 0.0.0.0 -p 8080"]
EXPOSE 8080



# FROM ubuntu:hirsute
# RUN mkdir /app
# WORKDIR /app
# COPY --from=build app/ /app
# ENTRYPOINT ["/app/theHarvester.py"]
# ENTRYPOINT ["/app/restfulHarvest.py -H 0.0.0.0 -p 8080"]
# EXPOSE 8080
