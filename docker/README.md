# Hive metastore standalone image
Hive metastore requires metastore db. This image requires Postgres DB.
## Required  parameters
Hive metastore requires postgres conneciton parameters.
| Param name | Example |
| -----------|-------- |
|DATABASE_PORT|5432|
|DATABASE_USER|admin|
|DATABASE_PASSWORD|pass|
|DATABASE_DB|mestastore|
|DATABASE_HOST|pghost|
