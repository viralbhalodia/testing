ARG BASE_REGISTRY=registry.access.redhat.com
ARG BASE_IMAGE=ubi8
ARG BASE_TAG=8.1
FROM $BASE_REGISTRY/$BASE_IMAGE:$BASE_TAG

LABEL name="PostgreSQL" \
    description="PostgreSQL container based off UBI8" \
    vendor="PostgreSQL" \
    summary="PostgreSQL (Red Hat UBI)" \
    maintainer="josheason@seed-innovations.com" \
    version="9.16.17"

ARG PGDATA=/var/lib/postgresql/data

ENV PGDATA=${PGDATA}

ENV PATH $PATH:/usr/pgsql-96/bin \
    LANG en_US.utf8

USER 0

COPY signatures/RPM-GPG-KEY-PGDG-96 \
    postgresql96-server-9.6.17-1PGDG.rhel8.x86_64.rpm \
    postgresql96-9.6.17-1PGDG.rhel8.x86_64.rpm \
    postgresql96-libs-9.6.17-1PGDG.rhel8.x86_64.rpm \
    /tmp/

RUN rpm --import /tmp/RPM-GPG-KEY-PGDG-96 && \
    dnf install -y /tmp/postgresql96-server-9.6.17-1PGDG.rhel8.x86_64.rpm /tmp/postgresql96-9.6.17-1PGDG.rhel8.x86_64.rpm /tmp/postgresql96-libs-9.6.17-1PGDG.rhel8.x86_64.rpm && \
    dnf clean all && \
    rm -rf /var/cache/dnf

RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir -p "$PGDATA" && chown -R postgres:postgres "$PGDATA" && chmod 777 "$PGDATA"

VOLUME /var/lib/postgresql/data

USER postgres

HEALTHCHECK --interval=5s --timeout=3s CMD /usr/pgsql-96/bin/pg_isready -U postgres

COPY scripts/docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]
