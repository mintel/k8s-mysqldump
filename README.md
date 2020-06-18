# k8s-mysqldump

An image for pulling dumps from a mysql database and pushing them to a Google bucket.

## Prerequisites

### Google Resources

* A Google bucket into which dumps will be copied.
* A Google service account with the correct read-write permissions to the bucket.

### Google Authentication

If an ENVironemnt variable named `RESTIC_GOOGLE_APPLICATION_CREDENTIALS` is specified pointing to a credentials.json file then it will be used to authenticate. 

Otherwise the standard [Application Default Credentials](https://cloud.google.com/docs/authentication/production) will be used, including support for Workload Identity

### Environment Variables

| Variable Name | Description | Default |
| ------------- | ----------- | ------- |
| DB_HOST | Host name/address of the MySQL instance. | N/A |
| DB_NAME | Name of the database from which the dump will be created. | N/A |
| DB_PASSWORD | Database user's password. | N/A |
| DB_USER | Database user name to be used for the dump. | N/A |
| RESTIC_GOOGLE_APPLICATION_CREDENTIALS | Path to JSON file containing Google service account credentials for the backup bucket (should be mounted as a volume). | /secrets/bucket/credentials.json |
| RESTIC_GOOGLE_PROJECT_ID | The ID of the Google Project in which the Bucket is stored. | N/A |
| RESTIC_PASSWORD | Password for encrypting/decrypting the dumps stored in the bucket. | N/A |
| RESTIC_REPOSITORY | The full path to where the data will be stored on the bucket (e.g. gs:my-bucket:/path/to/folder). | N/A |
| RESTIC_RUNNER_REPO | The name of the repo config file to use (as defined by [restic-runner](https://github.com/alphapapa/restic-runner)).
| RESTIC_RUNNER_SET | The name of the set config file to use (as defined by [restic-runner](https://github.com/alphapapa/restic-runner)).
| TABLE_FILE | Path to file containing a line-separated list of tables. If not provided it will dump all tables in the database. | N/A |

## Development

To get this working locally, first run `./hack/dev-setup.sh`. This will set up your `./private` directory structure and a `.env` file with the required variables for docker-compose (you'll need to update this with your own values). The included `./docker-compose.yml` file shows how to get this working with Google Cloud SQL.
