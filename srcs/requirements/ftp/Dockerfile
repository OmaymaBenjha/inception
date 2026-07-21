FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y proftpd-core && \
    rm -rf /var/lib/apt/lists/*

COPY conf/proftpd.conf /etc/proftpd/proftpd.conf
COPY tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

EXPOSE 21 50000-50100

CMD ["/usr/local/bin/script.sh"]