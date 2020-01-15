#!/usr/bin/env bash

set -e

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$HERE"/../

mkdir -p private/credentials
mkdir -p private/data

if [[ ! -f .env ]]; then
  cat <<EOF > .env
BUCKET_CREDENTIALS=/secrets/bucket/credentials.json
CLOUDSQL_CREDENTIALS=/secrets/cloudsql/credentials.json
BUCKET_NAME=
DB_CONNECTION_STRING=
DB_HOST=cloudsql-proxy
DB_NAME=
DB_PASSWORD=
DB_USER=
TABLE_FILE=/config/tables.txt
EOF
fi