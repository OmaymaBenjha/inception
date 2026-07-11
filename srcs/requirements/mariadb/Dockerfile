FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server 

RUN  sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/'  /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

EXPOSE 3306

ENTRYPOINT ["bash", "/usr/local/bin/script.sh"]