psql -U postgres -c "CREATE DATABASE contracts"
pg_restore --list /data | sed '/MATERIALIZED VIEW DATA/d' > /dump/restore.list
pg_restore -U postgres --no-owner --jobs 16 --dbname contracts --verbose --exit-on-error --use-list /dump/restore.list /data
