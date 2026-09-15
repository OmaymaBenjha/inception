FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx

# Generate SSL certs for the website


COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./tools /var/www/html/

EXPOSE 3000

ENTRYPOINT ["nginx", "-g", "daemon off;"]