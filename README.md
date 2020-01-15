# k8s-mysqldump

An image for pulling mysql dumps from a database and pushing them to a Google bucket.

## Prerequisites

### Google Resources

* A Google bucket into which dumps will be copied.
* A Google service account with the correct read-write permissions to the bucket.

### Environment Variables

| Variable Name | Description | Default |
| ------------- | ----------- | ------- |
| BUCKET_CREDENTIALS | Path to JSON file containing Google service account credentials for the backup bucket (should be mounted as a volume) | /secrets/bucket/credentials.json |
| BUCKET_NAME | Globally unique name of the Google bucket | N/A |
| DB_HOST | Host name/address of the MySQL instance | N/A |
| DB_NAME | Name of the database from which the dump will be created | N/A |
| DB_PASSWORD | Database user's password | N/A |
| DB_USER | Database user name to be used for the dump | N/A |
| TABLE_FILE | Path to file containing a line-separated list of tables. If unprovided it will dump all tables in the database | N/A |

## Development

To get this working locally, first run `./hack/dev-setup.sh`. This will set up your `./private` directory structure and a `.env` file with the required variables for docker-compose (you'll need to update this with your own values). The included `./docker-compose.yml` file shows how to get this working with Google Cloud SQL.