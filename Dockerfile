FROM mcreations/openwrt-java:8

LABEL maintainer="Ioanna M. Dimitriou <dimitriou@m-creations.com>"
LABEL version="3.4.10"
LABEL vendor="mcreations"
LABEL name="docker-openwrt-zookeeper"

EXPOSE 2181

ENV ZOOKEEPER_HOME /opt/zookeeper

# add user: 

ENV ZOOKEEPER_USER="zookeeper"
ENV ZOOKEEPER_GROUP="$ZOOKEEPER_USER"

# installation scripts are here:

RUN mkdir -p /var/lib/zookeeper

ADD image/root /
ADD data/ /var/lib/zookeeper

# install zookeeper

RUN bash /var/lib/zookeeper/install-zookeeper.sh

# start container with this script 

ENTRYPOINT ["/docker-entrypoint.sh"]

# with no arguments
 
CMD [ "" ]