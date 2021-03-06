FROM registry.access.redhat.com/ubi8:8.2

LABEL name="PostgreSQL" \
    description="PostgreSQL container based off UBI8" \
    vendor="PostgreSQL" \
    summary="PostgreSQL (Red Hat UBI)" \
    maintainer="josheason@seed-innovations.com" \
    version="9.16.18"

ARG PGDATA=/var/lib/postgresql/data

USER 0

COPY signatures/RPM-GPG-KEY-PGDG-96 \
    /tmp/

COPY scripts/docker-entrypoint.sh /usr/local/bin/

RUN rpm --import /tmp/RPM-GPG-KEY-PGDG-96 && \
    dnf install -y glibc-langpack-en /tmp/postgresql96-server.rpm /tmp/postgresql96.rpm /tmp/postgresql96-libs.rpm && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir -p "$PGDATA" && chown -R postgres:postgres "$PGDATA" && chmod 777 "$PGDATA"

VOLUME /var/lib/postgresql/data

USER postgres

ENV PGDATA=${PGDATA}
ENV PATH $PATH:/usr/pgsql-9.6/bin
ENV LANG en_US.utf8

HEALTHCHECK --interval=5s --timeout=3s CMD /usr/pgsql-96/bin/pg_isready -U postgres

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]
