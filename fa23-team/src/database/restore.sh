psql -U postgres -c "DROP DATABASE IF EXISTS contracts"
psql -U postgres -c "CREATE DATABASE contracts"

pg_restore --list /d/data_dump | sed '/MATERIALIZED VIEW DATA/d' > /d/restore.list
pg_restore -U postgres --no-owner --jobs 16 --dbname contracts --verbose --exit-on-error --schema-only --use-list /d/restore.list /d/data_dump

pg_restore -U postgres --no-owner --jobs 16 --dbname contracts --verbose --exit-on-error --data-only --schema=rpt --table=award_search --table=recipient_lookup --use-list /d/restore.list /d/data_dump