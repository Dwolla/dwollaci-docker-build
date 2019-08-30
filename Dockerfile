FROM alpinelinux/docker-cli:latest
LABEL maintainer="dev+dwollaci-docker-build@dwolla.com"

COPY build.sh /build.sh

VOLUME /docker-context
WORKDIR /docker-context

ENTRYPOINT ["/build.sh"]
