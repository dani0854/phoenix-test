#!/bin/sh
set -ex


# Pre
apk add --no-cache --virtual \
    wget                     \
    tar                      \
    gnupg                       
apk add --no-cache \
    bash           \
    openjdk8
mkdir /tmp/phoenix-test /tmp/hbase /tmp/zookeeper


# Install hbase
wget -O /tmp/phoenix-test/hbase-keys https://dist.apache.org/repos/dist/release/hbase/KEYS
gpg --import /tmp/phoenix-test/hbase-keys                             
wget -P /tmp/phoenix-test "$APACHE_MIRROR/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz"
wget -P /tmp/phoenix-test "https://www.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz.asc"
gpg --verify /tmp/phoenix-test/hbase-$HBASE_VERSION-bin.tar.gz.asc
tar zxf /tmp/phoenix-test/hbase-$HBASE_VERSION-bin.tar.gz -C /usr/local


# Install phoenix
wget -O /tmp/phoenix-test/phoenix-keys https://dist.apache.org/repos/dist/release/phoenix/KEYS
gpg --import /tmp/phoenix-test/phoenix-keys
wget -P /tmp/phoenix-test "$APACHE_MIRROR/phoenix/apache-phoenix-$PHOENIX_VERSION/bin/apache-phoenix-$PHOENIX_VERSION-bin.tar.gz"
wget -P /tmp/phoenix-test "https://www.apache.org/dist/phoenix/apache-phoenix-$PHOENIX_VERSION/bin/apache-phoenix-$PHOENIX_VERSION-bin.tar.gz.asc"
gpg --verify /tmp/phoenix-test/apache-phoenix-$PHOENIX_VERSION-bin.tar.gz.asc
tar zxf /tmp/phoenix-test/apache-phoenix-$PHOENIX_VERSION-bin.tar.gz -C /tmp/phoenix-test
cp /tmp/phoenix-test/apache-phoenix-$PHOENIX_VERSION-bin/phoenix-$PHOENIX_VERSION-server.jar $HBASE_HOME/lib/

# Clean
rm -r /tmp/phoenix-test
apk del  \
    wget \
    tar  \
    gnupg                   
rm /tmp/install.sh
