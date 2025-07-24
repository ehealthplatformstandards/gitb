FROM postgres:16

ENV POSTGRES_DB=gitb
ENV POSTGRES_USER=gitb
ENV POSTGRES_PASSWORD=gitb

COPY gitb-entrypoint.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/gitb-entrypoint.sh

COPY postgresql.conf /etc/postgresql/postgresql.conf
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
