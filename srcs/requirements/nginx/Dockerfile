FROM  debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl  && \
	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=oben-jha.42.fr/UID=oben-jha"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN  mkdir -p /var/www/html

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
