FROM postgres:12-bullseye

WORKDIR /data
COPY ./data_dump .

WORKDIR /dump
WORKDIR /

COPY ./restore.sh .
# RUN psql -U postgres -c "CREATE DATABASE contracts"

# RUN  pg_restore --list /data | sed '/MATERIALIZED VIEW DATA/d' > /dump/restore.list

# RUN pg_restore -U postgres --no-owner --jobs 16 --dbname contracts --verbose --exit-on-error --use-list /dump/restore.list /data
