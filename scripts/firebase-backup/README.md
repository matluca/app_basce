# Create and restore backups of ChiTiSplit's database

## Installation

Install dependencies using NPM:

```sh
npm ci
```

This project uses Node version 16.

Database credentials should be stored in a file called `serviceAccountKey.json` in the root directory.
Credentials can be generated from the Firebase console in "Service Account > Generate Private Key". 

## Usage

Create a backup with:

```shell
npm run backup ./firestore-backup.json
```

Restore backup with:

```shell
npm run restore ./firestore-backup.json
```

Restoring a backup does not delete existing records: it overrides or adds new data to the collection.
For a clean data restore, clear the entire database first:

```shell
npm run clear
```
