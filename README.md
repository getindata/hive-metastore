# hive-metastore
Hive-metastore helm chart
## Installation
Hive metastore requires Postgres DB. It can be configured with values e.g.:
```
postgres:
  host: "postgresql"
  port: 5432
  db: metastore
  username: admin
  password: pass
```
The docker image is published on github repository (ghcr.io). Login to github repository to pull image:
```
docker login ghcr.io -u [github_username]
```
To install hive-metastore execute
```
helm install hms hive-metastore
```