# USER_DOC.md

# User Documentation

## Services

The infrastructure provides the following services:

- **NGINX**: HTTPS entry point for the WordPress website.
- **WordPress + PHP-FPM**: Website application.
- **MariaDB**: WordPress database.
- **Redis**: WordPress cache.
- **Adminer**: Database administration interface.
- **FTP**: Access to the WordPress website files.
- **Static website**: Additional static website service.
- **Backup**: Periodic backup of MariaDB data.

## Start the project

From the project root:

```bash
make
```

## Stop the project

```bash
make stop
```

## Start stopped containers

```bash
make start
```

## Remove the containers

```bash
make clean
```

## Remove the project data and Docker resources

```bash
make fclean
```

## Access the website

Open:

```text
[https://oben-jha.42.fr](https://oben-jha.42.fr)
```

The browser may display a warning because the project uses a self-signed TLS certificate.

## Access WordPress

The WordPress website is available through the domain above.

The WordPress administrator account is created during the WordPress container initialization.

## Access Adminer

Adminer is available through:

```text
[https://oben-jha.42.fr/adminer](https://oben-jha.42.fr/adminer)
```

It is used to manage the MariaDB database.

## Access the static website

The additional static website is available through:

```text
[https://oben-jha.42.fr/website/](https://oben-jha.42.fr/website/)
```

## Access FTP

The FTP service uses port `21` and passive ports `50000-50100`.

A compatible FTP client such as FileZilla can be used with:

- Host: `oben-jha.42.fr`
- Port: `21`
- User: the FTP user defined in `.env`
- Password: the FTP password defined in `.env`

## Credentials

Project credentials are stored in the local `.env` file.

Do not publish the `.env` file or its passwords in the Git repository.

The `.env` file contains credentials for:

- MariaDB
- WordPress administrator
- WordPress user
- Redis
- FTP

## Check the services

List running containers:

```bash
docker ps
```

Check the Compose services:

```bash
docker compose -f srcs/docker-compose.yml ps
```

View the logs of a service:

```bash
docker logs <container_name>
```

For example:

```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```