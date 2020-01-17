#!/usr/bin/env bash

set -e

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$HERE"/../

mkdir -p private/credentials
mkdir -p private/data

if [[ ! -f .env ]]; then
  cat <<EOF > .env
# CLOUDSQL
CLOUDSQL_GOOGLE_APPLICATION_CREDENTIALS=/secrets/cloudsql/credentials.json
CLOUDSQL_CONNECTION_STRING=

# DATABASE
DB_HOST=cloudsql-proxy
DB_NAME=
DB_PASSWORD=
DB_USER=
TABLE_FILE=/config/tables.txt

# RESTIC
RESTIC_GOOGLE_APPLICATION_CREDENTIALS=/secrets/bucket/credentials.json
RESTIC_GOOGLE_PROJECT_ID=
RESTIC_PASSWORD=
RESTIC_REPOSITORY=
RESTIC_RUNNER_SET=
RESTIC_RUNNER_REPO=
EOF
fi