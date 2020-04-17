# Description

PostgreSQL v9.6 server based on RedHat UBI 8. Supported through November 11, 2021.

# Configuration

## Exposed Ports

Port | Description
--- | ---
5432/tcp | Main PostgreSQL application port.

## Environment Variables

Variable | Description | Required
--- | --- | ---
POSTGRES_USER | Defines the superuser's username. Defaults to `postgres`. | No
POSTGRES_PASSWORD | Defines the superuser password for POSTGRES_USER. | Yes
POSTGRES_DB | Defines the default database when image is first started. Defaults to the value of POSTGRES_USER. | No
POSTGRES_INITDB_ARGS | Used to send arguments to `postgres initdb`. | No
POSTGRES_INITDB_WALDIR | Defines an alternate location for the transaction log. Defaults to a subdirectory of `PGDATA`. | No
POSTGRES_HOST_AUTH_METHOD | Defines the auth-method used for host connections for all databases, users, and addresses. If unspecified, md5 password authentication is used. | No
PGDATA | Directory used for storing database files. | No

## Official Configuration Details

Please see the official [PostgreSQL image on Docker Hub](https://hub.docker.com/_/postgres) for more information on what configuration options are available.

# Deployment

## Helm Charts

PostgreSQL can be deployed with the following Helm charts, provided by Bitnami:
- [Standard deployment](https://github.com/bitnami/charts/tree/master/bitnami/postgresql)
- [High Availability deployment](https://github.com/bitnami/charts/tree/master/bitnami/postgresql-ha)
