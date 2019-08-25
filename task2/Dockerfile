FROM alpine
MAINTAINER Aleksandr Samsonov <Aleksandr_Samsonov@epam.com>
RUN apk update && apk upgrade && apk add openjdk8 openjdk8-jre vim openssh-client wget tar
RUN mkdir -p /cluster && mkdir -p /cluster/downloads
WORKDIR /cluster/downloads
RUN wget https://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz && tar -xvf zookeeper-3.4.6.tar.gz && wget https://archive.apache.org/dist/hadoop/core/hadoop-2.6.0/hadoop-2.6.0.tar.gz && tar -xvf hadoop-2.6.0.tar.gz
WORKDIR /cluster
RUN mv /cluster/downloads/hadoop-2.6.0 /cluster && mv /cluster/downloads/zookeeper-3.4.6 /cluster
COPY .bashrc /cluster/
WORKDIR /cluster/zookeeper-3.4.6/conf 
RUN cp zoo_sample.cfg zoo.cfg && mkdir /cluster/zookeepder-data && echo "Server.1=nn1.cluster.com:2888:3888\nServer.2=nn2.cluster.com:2888:3888\nServer.3=dn1.cluster.com:2888:3888\n" >>zoo.cfg
WORKDIR /cluster
