#!/bin/bash

# to toggle debugging comment/uncomment the following:
set -x

# variables

ZOOKEEPER_VERSION="3.4.10"
ZOOKEEPER_ARTIFACT="zookeeper-${ZOOKEEPER_VERSION}"
ZOOKEEPER_FILE="${ZOOKEEPER_ARTIFACT}.tar.gz"
ZOOKEEPER_DOWNLOAD_URL="http://apache.mirror.digionline.de/zookeeper/stable/${ZOOKEEPER_FILE}"
ZOOKEEPER_MD5_DOWNLOAD_URL="https://www.apache.org/dist/zookeeper/stable/${ZOOKEEPER_FILE}.md5"

# get necessary openWRT packages
opkg update
opkg install libstdcpp shadow-groupadd shadow-useradd shadow-su

# add zookeeper user, group, and home directories

mkdir /home "$ZOOKEEPER_HOME"
usr/sbin/useradd -d "/home/${ZOOKEEPER_USER}" -m -s /bin/bash -U "$ZOOKEEPER_USER"
cp /root/.bashrc "/home/$ELASTIC_USER"
echo 'alias hostname="echo $HOSTNAME"' >> /etc/profile

# download zookeeper 
wget -nv "${ZOOKEEPER_DOWNLOAD_URL}"

# download md5 sum of above file
wget -nv "${ZOOKEEPER_MD5_DOWNLOAD_URL}"

# the md5 sum according to elastic.co: 
SUM=$(cat "${ZOOKEEPER_FILE}.md5")

# the md5 sum we calculate
NEWSUM=$(md5sum "$ZOOKEEPER_FILE")

if [ "$SUM" == "$NEWSUM" ] && [ "$SUM" != "" ] 
then echo "MD5 SUM OK"
else echo "MD5 SUM FAILED!!!" 
     exit 1
fi

# install zookeeper:

tar -xvzf "/${ZOOKEEPER_FILE}"
mv -f /${ZOOKEEPER_ARTIFACT}/* "$ZOOKEEPER_HOME"

## TEMPORARY: cp config file
mkdir "${ZOOKEEPER_HOME}/bin/conf"

# chown $zookeeper_home
chown -R "${ZOOKEEPER_USER}:${ZOOKEEPER_GROUP}" "$ZOOKEEPER_HOME"

# remove unecessary packages and files
rm /tmp/opkg-lists/* 
rm "/${ZOOKEEPER_FILE}"
rm "/${ZOOKEEPER_FILE}.md5"

