FROM debian:bookworm

RUN apt-get update

RUN mkdir /backup

ADD ./tools/run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

ENTRYPOINT /usr/bin/run.sh