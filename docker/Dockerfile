FROM amazoncorretto:8u442-alpine3.21-jre

ARG HADOOP_VERSION=3.4.1
ARG HIVE_METASTORE_VERSION=3.0.0
ARG POSTGRES_CONNECTOR_VERSION=42.7.2

WORKDIR /app
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apk update && apk upgrade && apk add net-tools gettext curl

RUN echo "Download and extract the Hadoop binary package" && \
    curl https://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
    | tar xvz -C /opt/ && \
    ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop && \
    rm -r /opt/hadoop/share/doc
RUN echo "Download and install the standalone metastore binary" && \
    curl https://downloads.apache.org/hive/hive-standalone-metastore-$HIVE_METASTORE_VERSION/hive-standalone-metastore-$HIVE_METASTORE_VERSION-bin.tar.gz \
    | tar xvz -C /opt/ && \
    ln -s /opt/apache-hive-metastore-$HIVE_METASTORE_VERSION-bin /opt/hive-metastore
RUN echo "Fix 'java.lang.NoSuchMethodError: com.google.common.base.Preconditions.checkArgument'" && \
    echo "Keep this until this lands: https://issues.apache.org/jira/browse/HIVE-22915" && \
    rm /opt/apache-hive-metastore-$HIVE_METASTORE_VERSION-bin/lib/guava-19.0.jar && \
    cp /opt/hadoop-$HADOOP_VERSION/share/hadoop/hdfs/lib/guava-27.0-jre.jar /opt/apache-hive-metastore-$HIVE_METASTORE_VERSION-bin/lib/
RUN echo "Download and install the database connector" && \
    curl -L https://jdbc.postgresql.org/download/postgresql-$POSTGRES_CONNECTOR_VERSION.jar --output /opt/postgresql-$POSTGRES_CONNECTOR_VERSION.jar && \
    ln -s /opt/postgresql-$POSTGRES_CONNECTOR_VERSION.jar /opt/hadoop/share/hadoop/common/lib/ && \
    ln -s /opt/postgresql-$POSTGRES_CONNECTOR_VERSION.jar /opt/hive-metastore/lib/


RUN rm /opt/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.9.4.jar
RUN echo "Download and install the database connector" && \
    curl -L https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.9.6/jackson-databind-2.9.7.jar --output /opt/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.9.7.jar

RUN rm /opt/apache-hive-metastore-3.0.0-bin/lib/derby-10.10.2.0.jar
RUN echo "Download and install the database connector" && \
    curl -L https://repo1.maven.org/maven2/org/apache/derby/derby/10.14.3/derby-10.14.3.jar --output /opt/apache-hive-metastore-3.0.0-bin/lib/derby-10.14.3.jar

RUN rm /opt/apache-hive-metastore-3.0.0-bin/lib/log4j-1.2-api-2.8.2.jar
RUN rm /opt/apache-hive-metastore-3.0.0-bin/lib/log4j-api-2.8.2.jar
RUN rm /opt/apache-hive-metastore-3.0.0-bin/lib/log4j-core-2.8.2.jar
RUN rm /opt/apache-hive-metastore-3.0.0-bin/lib/log4j-slf4j-impl-2.8.2.jar
RUN echo "Download and install the database connector" && \
    curl -L https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-1.2-api/2.16.0/log4j-1.2-api-2.16.0.jar --output /opt/apache-hive-metastore-3.0.0-bin/lib/log4j-1.2-api-2.16.0.jar && \
    curl -L https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.16.0/log4j-api-2.16.0.jar --output /opt/apache-hive-metastore-3.0.0-bin/lib/log4j-api-2.16.0.jar && \
    curl -L https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.16.0/log4j-core-2.16.0.jar --output /opt/apache-hive-metastore-3.0.0-bin/lib/log4j-core-2.16.0.jar && \
    curl -L https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-slf4j-impl/2.16.0/log4j-slf4j-impl-2.16.0.jar --output /opt/apache-hive-metastore-3.0.0-bin/lib/log4j-slf4j-impl-2.16.0.jar

RUN rm /opt/hadoop-3.4.1/share/hadoop/hdfs/lib/avro-1.9.2.jar
RUN rm /opt/hadoop-3.4.1/share/hadoop/common/lib/avro-1.9.2.jar
RUN echo "Download and install the database connector" && \
    curl -L https://repo1.maven.org/maven2/org/apache/avro/avro/1.11.4/avro-1.11.4.jar --output /opt/hadoop-3.4.1/share/hadoop/hdfs/lib/avro-1.9.2.jar \
    curl -L https://repo1.maven.org/maven2/org/apache/avro/avro/1.11.4/avro-1.11.4.jar --output /opt/hadoop-3.4.1/share/hadoop/common/lib/avro-1.9.2.jar

RUN rm /opt/hadoop-3.4.1/share/hadoop/yarn/timelineservice/lib/htrace-core-3.1.0-incubating.jar
RUN rm /opt/hadoop-3.4.1/share/hadoop/client/hadoop-client-runtime-3.4.1.jar
RUN rm /opt/hadoop-3.4.1/share/hadoop/yarn/hadoop-yarn-applications-catalog-webapp-3.4.1.war

RUN apk add --no-cache bash

COPY hive-site.xml hive-site_TEMPLATE.xml
COPY metastore-site.xml metastore-site_TEMPLATE.xml
COPY --chmod=755 run.sh run.sh

ENV HADOOP_HOME="/opt/hadoop"
ENV PATH="/opt/hadoop/bin:${PATH}"
ENV METASTORE_PORT=9083
ENV DATABASE_DRIVER=org.postgresql.Driver
ENV DATABASE_TYPE=postgres
ENV DATABASE_TYPE_JDBC=postgresql
# ENV DATABASE_PORT=5432
# ENV DATABASE_USER=admin
# ENV DATABASE_PASSWORD=pass
# ENV DATABASE_DB=metastore
# ENV DATABASE_HOST=metastore-db

CMD [ "./run.sh" ]
HEALTHCHECK CMD [ "sh", "-c", "netstat -ln | grep 9083" ]