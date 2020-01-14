# k8s-mysqldump

An image for pulling mysql dumps from a database and pushing them to a Google bucket.

## Prerequisites

### Google Resources

* A Google bucket into which dumps will be copied.
* A Google service account with the correct read-write permissions to the bucket.

### Environment Variables

| Variable Name | Description | Default |
| ------------- | ----------- | ------- |
| BUCKET_CREDENTIALS | Path to JSON file containing Google service account credentials (should be mounted as a volume) | /secrets/bucket/credentials.json |
| BUCKET_NAME | Globally unique name of the Google bucket | N/A |
| DB_HOST | Host name/address of the MySQL instance | N/A |
| DB_NAME | Name of the database from which the dump will be created | N/A |
| DB_PASSWORD | Database user's password | N/A |
| DB_USER | Database user name to be used for the dump | N/A |
| TABLE_FILE | Path to file containing a line-separated list of tables. If unprovided it will dump all tables in the database | N/A |
