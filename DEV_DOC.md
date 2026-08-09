# Developer Documentation
 
This document explains how to set up, build, and work on the Inception project as a
developer: environment prerequisites, configuration/secrets, build & run commands,
container/volume management, and where project data lives.
 
## 1. Prerequisites
 
- A Virtual Machine (the subject requires this project to run inside a VM, not bare
  metal).
- Docker Engine + the `docker compose` plugin installed on the VM.
- The domain `oben-jha.42.fr` resolving to the VM's local IP (e.g. an `/etc/hosts`
  entry on the client, or a DNS entry on the VM itself pointing to `127.0.0.1`).
## 2. Repository layout
 
```
.
├── Makefile
└── srcs/
    ├── .env                     # environment variables (not committed)
    ├── docker-compose.yml
    └── requirements/
        ├── nginx/
        ├── wordpress/
        ├── mariadb/
        ├── redis/                # bonus: WordPress cache
        ├── adminer/               # bonus: DB admin UI
        ├── ftp/                   # bonus: FTP access to wp-data
        ├── website/                # bonus: static portfolio site
        └── portainer/              # bonus: container management UI
```
 
Each service directory contains its own `Dockerfile` (and `conf/`, `tools/`
subfolders where relevant, e.g. entrypoint scripts and config files). Every image is
built from `debian:bookworm` — nothing is pulled pre-built except the base OS image,
per the subject's rules.
 
## 3. Configuration and secrets
 
All configuration is centralized in `srcs/.env`, loaded by every service via
`env_file: .env` in `docker-compose.yml`. It currently defines:
 
- `DOMAIN_NAME` — the site's domain (`oben-jha.42.fr`)
- `SQL_DB`, `SQL_USR`, `SQL_PWD`, `SQL_ROOT_PWD` — MariaDB setup
- `WP_ADMIN_USR`, `WP_ADMIN_PWD`, `WP_ADMIN_EMAIL` — WordPress admin account
- `WP_USR`, `WP_EMAIL`, `WP_PWD` — a second, non-admin WordPress user
- `FTP_USER`, `FTP_PWD` — FTP account for the `ftp` bonus service
`.env` must never be committed to Git and must be created locally before running
`make`. No password is hardcoded in any Dockerfile or script — everything is read
from these environment variables at container start.
 
## 4. Building and launching
 
```bash
make        # mkdir -p the three host data dirs, then `docker compose up -d --build`
make clean  # docker compose down
make fclean # clean + wipe host data dirs + docker system prune -af --volumes
make re     # fclean followed by make
```
 
Under the hood, `make all` runs:
 
```bash
docker compose -f srcs/docker-compose.yml up -d --build
```
 
which builds each service's Dockerfile as declared in `srcs/docker-compose.yml` and
starts every container attached to the `inception` bridge network.
 
## 5. Managing containers and volumes
 
```bash
# Status of all services
docker compose -f srcs/docker-compose.yml ps
 
# Rebuild + restart a single service
docker compose -f srcs/docker-compose.yml up -d --build wordpress
 
# Logs
docker compose -f srcs/docker-compose.yml logs -f <service>
 
# Shell into a running container
docker exec -it <service> bash
 
# List volumes and inspect where they're mounted
docker volume ls
docker volume inspect srcs_db-data
```
 
## 6. Where data lives and how it persists
 
Two named volumes back the persistent data, both configured with the `local` driver
using a **bind-style mount under the hood** (`driver_opts: type: none, o: bind`) so
Docker manages them as named volumes while the data physically sits at a fixed host
path, as required by the subject:
 
- `db-data` → `/home/oben-jha/data/mariadb` (MariaDB's `/var/lib/mysql`)
- `wp-data` → `/home/oben-jha/data/wordpress` (WordPress's `/var/www/html`, shared
  read/write with `nginx` and `ftp`)
- `portainer-data` (bonus) → `/home/oben-jha/data/portainer`
Because the data lives outside the containers, `make clean` (which only removes
containers) leaves it intact — a subsequent `make` reuses the existing database and
WordPress install. `make fclean` is the only target that deletes this data, so use it
deliberately when a fully fresh install is needed.
 
## 7. Service-specific notes
 
- **mariadb**: on first boot (`/var/lib/mysql/mysql` absent), the entrypoint runs
  `mysqld --bootstrap` to create the database/user and set the root password, then
  execs the real `mysqld` process as PID 1 — no supervisor or `tail -f` hack.
- **wordpress**: the entrypoint uses `wp-cli` to download core, write `wp-config.php`,
  run `wp core install`, create the admin and a secondary user, and configure the
  Redis object-cache plugin, all idempotently (skipped if `wp-config.php` already
  exists).
- **nginx**: terminates TLS (`TLSv1.2`/`TLSv1.3` only) on `443`, proxies `.php`
  requests to `wordpress:9000` and `/adminer` to `adminer:9000` via FastCGI.
- **redis**, **adminer**, **ftp**, **website**, **portainer**: bonus services, each
  with its own Dockerfile; `redis` and `adminer` are on the `inception` network,
  `ftp`/`website`/`portainer` additionally expose their own host ports.
 