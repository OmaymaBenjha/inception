FROM debian:bookworm

RUN apt-get update -y && \
    apt-get install -y mariadb-server
COPY tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh


ENTRYPOINT ["bash", "/usr/local/bin/script.sh"]