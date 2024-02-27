#!/usr/bin/env bash

set -euxo pipefail

envsubst < hive-site_TEMPLATE.xml > /opt/hadoop/etc/hadoop/hive-site.xml
envsubst < metastore-site_TEMPLATE.xml > /opt/hive-metastore/conf/metastore-site.xml

cat /opt/hadoop/etc/hadoop/hive-site.xml
cat /opt/hive-metastore/conf/metastore-site.xml

if /opt/hive-metastore/bin/schematool -dbType "$DATABASE_TYPE" -validate | grep 'Done with metastore validation' | grep '[SUCCESS]'; then
    echo 'Metastore already initialized'
else
    echo 'Metastore - initializing schema'
    /opt/hive-metastore/bin/schematool --verbose -dbType "$DATABASE_TYPE" -initSchema
    echo 'Metastore - schema initialized'
fi

/opt/hive-metastore/bin/start-metastore
