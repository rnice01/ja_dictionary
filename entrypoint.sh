#!/bin/bash
# docker entrypoint script.

# assign a default for the database_user
DB_USER=${DATABASE_USER:-postgres}

# wait until Postgres is ready
while ! pg_isready -q -h $DATABASE_HOST -p 5432 -U $DB_USER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

bin="/app/bin/ja_study_tools"
eval "$bin eval \"JaStudyTools.Release.migrate\""
eval "pg_restore -U$DB_USER -h$DATABASE_HOST -dpostgres ja_study_tools.dump.sql"
# start the elixir application
exec "$bin" "start"