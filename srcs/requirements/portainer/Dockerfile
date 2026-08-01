FROM debian:bookworm

RUN apt-get update && apt-get install -y wget tar ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz && \
    tar -xvf portainer-2.19.4-linux-amd64.tar.gz && \
    rm portainer-2.19.4-linux-amd64.tar.gz && \
    mv portainer /opt/portainer

EXPOSE 9443

ENTRYPOINT ["/opt/portainer/portainer"]