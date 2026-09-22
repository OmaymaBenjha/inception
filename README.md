*This project has been created as part of the 42 curriculum by oben-jha.*

# Description

## Project description

Inception is a system administration project based on Docker. The goal is to build a small infrastructure inside a virtual machine using Docker Compose and custom Dockerfiles.

The mandatory stack contains:

- NGINX with TLSv1.2/TLSv1.3
- WordPress with PHP-FPM
- MariaDB
- A Docker network connecting the services
- Persistent WordPress and MariaDB data

The project also contains the following bonus services:

- Redis cache
- FTP server
- Adminer
- A static website
- A backup service

Each service runs in its own container and is built from Debian Bookworm images.

## Docker and design choices

Docker is used to isolate the different services into separate containers while allowing them to communicate through a Docker network.

NGINX is the only public entry point of the main WordPress infrastructure and exposes port 443. It communicates with WordPress through PHP-FPM.

MariaDB stores the WordPress database. WordPress stores its website files in a persistent volume.

The project uses environment variables through `.env` for configuration. Credentials must not be committed to the Git repository.

### Virtual Machines vs Docker

A virtual machine virtualizes hardware and runs a complete guest operating system with its own kernel.

Docker containers share the host kernel and isolate applications using operating-system features such as namespaces and cgroups. Containers therefore do not require a complete guest operating system for each service.

### Secrets vs Environment Variables

Environment variables are used to provide configuration values to containers.

Docker secrets are designed to handle sensitive information without putting passwords directly into Dockerfiles or regular environment configuration.

For this project, the `.env` file is used for environment variables and must remain private.

### Docker Network vs Host Network

A Docker network gives containers their own network environment and allows services to communicate with each other by service name.

Host networking makes a container use the host network directly. The project uses a Docker network instead of `network: host`.

### Docker Volumes vs Bind Mounts

Docker volumes are managed by Docker and provide persistent storage for container data.

Bind mounts directly map a host directory into a container.

The subject requires the two mandatory persistent storages to be Docker named volumes. The current Compose configuration maps the named volumes to `/home/oben-jha/data/...` on the host.

# Instructions

## Prerequisites

- A virtual machine
- Docker
- Docker Compose
- Git

The project must be run from the repository root.

## Start the project

```bash
make
```

This creates the host data directories and builds and starts the Docker Compose infrastructure.

## Stop the project

```bash
make stop
```

## Start stopped containers

```bash
make start
```

## Stop and remove containers

```bash
make clean
```

## Remove containers, data and Docker resources

```bash
make fclean
```

## Rebuild the project

```bash
make re
```

The website is available at:

```text
[https://oben-jha.42.fr](https://oben-jha.42.fr)
```

# Resources

- Docker documentation: https://docs.docker.com/
- Docker Compose documentation: https://docs.docker.com/compose/
- NGINX documentation: https://nginx.org/en/docs/
- WordPress documentation: https://wordpress.org/documentation/
- WP-CLI documentation: https://wp-cli.org/
- MariaDB documentation: https://mariadb.com/kb/en/documentation/
- Redis documentation: https://redis.io/docs/
- ProFTPD documentation: http://www.proftpd.org/docs/
- Adminer: https://www.adminer.org/

## AI usage

AI was used as a learning and assistance tool during the project. It was used to help understand Docker, Docker Compose, networking, volumes, NGINX, PHP-FPM, MariaDB, Redis, FTP and related system administration concepts, and to help troubleshoot configuration and runtime errors.

All generated information and solutions were reviewed and tested in the project.