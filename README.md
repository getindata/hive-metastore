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
To install hive-metastore:
```
helm repo add getindata-hms https://getindata.github.io/hive-metastore
helm install hms getindata-hms/hive-metastore
```
Essential libraries for Flink 1.19.1
(/opt/flink/lib)

 - https://repo1.maven.org/maven2/org/apache/thrift/libfb303/0.9.3/libfb303-0.9.3.jar
 - https://repo1.maven.org/maven2/org/apache/hive/hive-exec/3.1.3/hive-exec-3.1.3.jar
 - https://repository.cloudera.com/artifactory/cloudera-repos/org/apache/flink/flink-shaded-hadoop-3-uber/3.1.1.7.0.3.0-79-7.0/flink-shaded-hadoop-3-uber-3.1.1.7.0.3.0-79-7.0.jar
 - https://repo1.maven.org/maven2/org/apache/flink/flink-connector-hive_2.12/1.19.1/flink-connector-hive_2.12-1.19.1.jar
 - https://repo1.maven.org/maven2/commons-cli/commons-cli/1.4/commons-cli-1.4.jar

Example hive-site.xml
```
<configuration>
   <!-- PostgreSQL connection details -->
   <property>
      <name>javax.jdo.option.ConnectionURL</name>
      <value>jdbc:postgresql://postgres-postgresql:5432/metastore</value>
      <description>Metadata is stored in a PostgreSQL server</description>
   </property>

   <property>
      <name>javax.jdo.option.ConnectionDriverName</name>
      <value>org.postgresql.Driver</value>
      <description>PostgreSQL JDBC driver class</description>
   </property>

   <property>
      <name>javax.jdo.option.ConnectionUserName</name>
      <value>admin</value>
      <description>Username for connecting to the PostgreSQL server</description>
   </property>

   <property>
      <name>javax.jdo.option.ConnectionPassword</name>
      <value>pass</value>
      <description>Password for connecting to the PostgreSQL server</description>
   </property>

   <!-- Hive Metastore service details -->
   <property>
       <name>hive.metastore.uris</name>
       <value>thrift://hms-hive-metastore:9083</value>
       <description>IP address (or fully-qualified domain name) and port of the metastore host</description>
   </property>

   <property>
       <name>hive.metastore.schema.verification</name>
       <value>true</value>
   </property>
</configuration>
```
