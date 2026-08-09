# User Documentation

This document explains, from an end-user / administrator point of view, how to use the
Inception infrastructure: what it provides, how to start and stop it, how to reach the
site and admin panel, where credentials live, and how to check that everything is
healthy.

## 1. What this stack provides

Running the project brings up the following services, each in its own container, all
connected through the `inception` Docker network:

| Service      | Role                                                              |
|--------------|--------------------------------------------------------------------|
| `nginx`      | Single entrypoint, serves HTTPS on port `443` (TLSv1.2/1.3 only)  |
| `wordpress`  | WordPress + php-fpm, the actual website                          |
| `mariadb`    | Database backing WordPress                                       |
| `redis`      | Object cache for WordPress                                       |
| `adminer`    | Lightweight web UI to inspect/manage the MariaDB database         |
| `ftp`        | FTP access to the WordPress files volume                         |
| `website`    | A small static portfolio site (bonus), served on port `3000`      |
| `portainer`  | Web UI to monitor/manage the Docker containers, port `9443`       |

Two named volumes persist data across restarts, both stored under
`/home/oben-jha/data/` on the host:
- `db-data` → MariaDB database files
- `wp-data` → WordPress files (also shared with `nginx` and `ftp`)

## 2. Starting and stopping the project

From the root of the repository:

```bash
make        # builds every image and starts all containers in the background
make clean  # stops and removes the containers
make fclean # clean + wipes persisted data (mariadb/wordpress/portainer) + prunes Docker
make re     # fclean + make, for a full fresh restart
```

`make` also creates the host data directories (`/home/oben-jha/data/mariadb`,
`/home/oben-jha/data/wordpress`, `/home/oben-jha/data/portainer`) before bringing the
stack up.

## 3. Accessing the website and admin panel

- WordPress site: `https://oben-jha.42.fr`
  (make sure `oben-jha.42.fr` resolves to the VM's IP, e.g. via `/etc/hosts` on the
  machine you're browsing from)
- WordPress admin dashboard: `https://oben-jha.42.fr/wp-admin`
- Adminer (database UI): `https://oben-jha.42.fr/adminer`
- Static portfolio site (bonus): `https://<vm-ip>:3000`
- Portainer (container management, bonus): `https://<vm-ip>:9443`

Only port `443` (nginx) is meant to be the entrypoint for the WordPress site itself;
the bonus services (`website`, `portainer`, `ftp`) expose their own additional ports.

## 4. Credentials

All credentials are defined as environment variables in `srcs/.env` (not committed to
Git). Current values used in this setup:

- **WordPress administrator**: username `oben-jha_boss` (deliberately avoids
  "admin"/"administrator" per the subject's rule), password and email set via
  `WP_ADMIN_PWD` / `WP_ADMIN_EMAIL` in `.env`.
- **WordPress regular user**: username from `WP_USR`, password from `WP_PWD`.
- **MariaDB**: application user/password from `SQL_USR` / `SQL_PWD`, database name
  `SQL_DB`, root password `SQL_ROOT_PWD`.
- **FTP**: username/password from `FTP_USER` / `FTP_PWD`.

To view or change any credential, open `srcs/.env` directly — never look for
passwords hardcoded in a Dockerfile, there aren't any.

## 5. Checking that everything is running correctly

List running containers and their status:

```bash
docker compose -f srcs/docker-compose.yml ps
```

All services should show as `Up`. Useful follow-up checks:

```bash
# Tail logs for a specific service
docker compose -f srcs/docker-compose.yml logs -f wordpress

# Confirm the site answers over HTTPS
curl -k https://oben-jha.42.fr

# Confirm the database is reachable
docker exec -it mariadb mariadb -u root -p
```

If a container keeps restarting, `docker compose logs <service>` is the first place
to look — every service is configured with `restart: always`, so a crash loop shows
up as repeated restarts rather than a permanently stopped container.