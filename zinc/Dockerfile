#
# Zinc
#
# Source: https://github.com/prabhatsharma/zinc
#
# A docker image for Zinc, a lightweight full text engine.
# Compaible with ElasticSearch
# Run with:
# dk run --rm -it -p 4080:4080 -v ${PWD}/data:/data zinc
#
# Based on https://github.com/prabhatsharma/zinc/blob/main/Dockerfile

FROM public.ecr.aws/bitnami/golang:latest as builder
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    git \
    ca-certificates && \
    update-ca-certificates

# Create appuser.
ENV USER=appuser
ENV UID=10001 

# See https://stackoverflow.com/a/55757473/12429735RUN 
RUN adduser \    
    --disabled-password \    
    --gecos "" \    
    --home "/nonexistent" \    
    --shell "/sbin/nologin" \    
    --no-create-home \    
    --uid "${UID}" \    
    "${USER}"

RUN git clone https://github.com/prabhatsharma/zinc.git $GOPATH/src/github.com/prabhatsharma/zinc/

WORKDIR $GOPATH/src/github.com/prabhatsharma/zinc/
RUN go get -d -v && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o zinc

# Start first time and set username/password
ENV FIRST_ADMIN_USER=""
ENV FIRST_ADMIN_PASSWORD=""

# Create runtime image
FROM scratch

# Import the user and group files from the builder.
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

# Copy the ssl certificates
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# Copy our static executable.
COPY --from=builder /go/src/github.com/prabhatsharma/zinc/zinc /go/bin/zinc

# Use an unprivileged user.
USER appuser:appuser

# Port on which the service will be exposed.
EXPOSE 4080

# Run the zinc binary.
ENTRYPOINT ["/go/bin/zinc"]
