# Zookeeper docker image from mcreations/openwrt-java:8

Based on:

https://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_systemReq

https://zookeeper.apache.org/doc/trunk/zookeeperStarted.html

The image building includes md5sum verification of the installation file. 

## Requirements 

[Docker](https://www.docker.com/)

## Installation 


Download or clone the repository and from inside the repository's directory execute: 

```
docker build . -t docker-openwrt-zookeeper:3.4.10
```

## Usage

To run a Zookeeper server listening on port 2181 execute:

```
docker run -p 2181:2181 docker-openwrt-zookeeper:3.4.10
```

