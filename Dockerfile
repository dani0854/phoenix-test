FROM alpine

ARG HBASE_VERSION=1.3.6
ARG PHOENIX_VERSION=4.14.2-HBase-1.3
ARG APACHE_MIRROR="http://apache-mirror.rbc.ru/pub/apache"


# Env
ENV LANG=en_US.utf8                                                                                   \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk                                                           \
    HBASE_HOME=/usr/local/hbase-$HBASE_VERSION                                                        \
    HBASE_CONF_DIR=/usr/local/hbase-$HBASE_VERSION/conf                                               \
    PATH=$PATH:usr/lib/jvm/java-1.8-openjdk/bin:/usr/local/hbase-$HBASE_VERSION/bin

# Install
COPY install.sh /tmp/

RUN chmod 755 /tmp/install.sh && \
    /tmp/install.sh


# Conf
COPY hbase-site.xml $HBASE_HOME/conf/

EXPOSE 2181 16000 16010 16020 16030

CMD hbase-daemon.sh start zookeeper     && \
    hbase-daemon.sh start regionserver && \
    hbase-daemon.sh foreground_start master
