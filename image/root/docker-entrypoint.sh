#!/bin/bash

set -x
cd /opt/zookeeper
su - zookeeper

# Add zookeeper as command if needed

# if no arguments are given to the container, or if the only argument is "zookeeper"
if   [[ -z "$1" || ( "$1" = 'zookeeper' && -z "$2" ) ]] 
# then start zookeeper with the default config file I made
then /opt/zookeeper/bin/zkServer.sh start /conf/zoo.cfg
# else just execute the argument that was given at the start of the container.
else exec $*
fi
