# Hive metastore (standalone) docker image
Requirements: postgres db.
Hive metastore will initialize schema on startup. Expose port 9083 to connect.
## Required  parameters
| Param name | Example |
| -----------|-------- |
|DATABASE_PORT|5432|
|DATABASE_USER|admin|
|DATABASE_PASSWORD|pass|
|DATABASE_DB|mestastore|
|DATABASE_HOST|pghost|
