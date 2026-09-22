# DEV_DOC.md

# Developer Documentation

## Prerequisites

The project is designed to run inside a virtual machine.

Install:

- Docker
- Docker Compose
- Make

## Project structure

The main project files are organized as follows:

```text
.
├── Makefile
└── srcs
    ├── .env
    ├── docker-compose.yml
    └── requirements
        ├── mariadb
        ├── nginx
        ├── wordpress
        └── bonus
            ├── adminer
            ├── backup
            ├── ftp
            ├── redis
            └── website
```

Each service has its own Dockerfile.

## Configuration

The main Compose configuration is:

```text
srcs/docker-compose.yml
```

Environment variables are stored in:

```text
srcs/.env
```

The `.env` file contains domain, database, WordPress, Redis and FTP configuration.

Sensitive credentials must not be committed to Git.

## Build and launch

From the repository root:

```bash
make
```

The Makefile creates:

```text
/home/oben-jha/data/mariadb
/home/oben-jha/data/wordpress
/home/oben-jha/data/backup
```

It then runs:

```bash
docker compose -f srcs/docker-compose.yml up -d --build
```

## Docker Compose commands

Check the services:

```bash
docker compose -f srcs/docker-compose.yml ps
```

Build the images:

```bash
docker compose -f srcs/docker-compose.yml build
```

Start the services:

```bash
docker compose -f srcs/docker-compose.yml up -d
```

Stop the services:

```bash
docker compose -f srcs/docker-compose.yml stop
```

Remove the containers:

```bash
docker compose -f srcs/docker-compose.yml down
```

## Makefile commands

```bash
make
make start
make stop
make clean
make fclean
make re
```

- `make`: build and start the infrastructure.
- `make start`: start stopped containers.
- `make stop`: stop running containers.
- `make clean`: remove the containers.
- `make fclean`: remove project data and unused Docker resources.
- `make re`: clean and rebuild the project.

## Containers

The Compose services are:

```text
mariadb
redis
wordpress
adminer
nginx
ftp
website
backup
```

Each service has its own container.

Check running containers:

```bash
docker ps
```

Inspect a container:

```bash
docker inspect <container_name>
```

View logs:

```bash
docker logs <container_name>
```

Open a shell in a running container:

```bash
docker exec -it <container_name> bash
```

## Network

The containers communicate through the Docker network:

```text
inception
```

The services can communicate using their Compose service names, for example:

```text
mariadb
wordpress
redis
adminer
website
```

NGINX communicates with WordPress through:

```text
wordpress:9000
```

## Volumes and persistence

The project uses the following named volumes:

```text
db-data
wp-data
backup-data
```

They are used for:

- `db-data`: MariaDB data.
- `wp-data`: WordPress website files.
- `backup-data`: database backups.

The configured host locations are:

```text
/home/oben-jha/data/mariadb
/home/oben-jha/data/wordpress
/home/oben-jha/data/backup
```

List Docker volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect db-data
```

## Service-specific configuration

### NGINX

NGINX configuration:

```text
srcs/requirements/nginx/conf/nginx.conf
```

It listens on port `443` and uses TLSv1.2 and TLSv1.3.

### WordPress

WordPress is initialized by:

```text
srcs/requirements/wordpress/tools/auto_config.sh
```

PHP-FPM listens on port `9000`.

### MariaDB

MariaDB initialization is handled by:

```text
srcs/requirements/mariadb/tools/script.sh
```

MariaDB listens on port `3306` inside the infrastructure.

### Redis

Redis configuration:

```text
srcs/requirements/bonus/redis/conf/redis.conf
```

Redis listens on port `6379`.

### FTP

ProFTPD configuration:

```text
srcs/requirements/bonus/ftp/conf/proftpd.conf
```

FTP uses port `21` and passive ports `50000-50100`.

### Backup

The backup service periodically copies MariaDB data into the backup volume.

Its script is:

```text
srcs/requirements/bonus/backup/tools/run.sh
```