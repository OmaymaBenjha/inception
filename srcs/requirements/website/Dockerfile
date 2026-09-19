FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx

COPY ./tools /var/www/html/

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]