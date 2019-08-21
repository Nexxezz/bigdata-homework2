FROM ubuntu
MAINTAINER Aleksandr Samsonov <Aleksandr_Samsonov@epam.com>
RUN apt-get -y update 
RUN apt-get -y install default-jre
RUN apt-get -y install default-jdk
RUN apt-get -y install wget
RUN cd
RUN mkdir downloads
RUN cd ./downloads
RUN wget https://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
RUN tar -xvf zookeeper-3.4.6.tar.gz
Run wget https://archive.apache.org/dist/hadoop/core/hadoop-2.6.0/hadoop-2.6.0.tar.gz
RUN tar –xvf hadoop-2.6.0.tar.gz
RUN cd ..
RUN mkdir cluster
RUN mv ./downloads/hadoop-2.6.0 ./cluster
RUN mv ./downloads/zookeeper-3.4.6 ./cluster
RUN echo "JAVA_HOME=\"/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java" >> /etc/environment
RUN echo "export HADOOP_HOME=/root/cluster/hadoop-2.6.0\nexport HADOOP_MAPRED_HOME=$HADOOP_HOME\nexport HADOOP_COMMON_HOME=$HADOOP_HOME\nexport HADOOP_HDFS_HOME=$HADOOP_HOME\nexport YARN_HOME=$HADOOP_HOME\nexport HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop\nexport YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop\nexport JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64\nexport ZOOKEEPER_HOME =/root/cluster/zookeeper-3.4.6\n export PATH=$PATH: $JAVA_HOME/bin: $HADOOP_HOME/bin: $HADOOP_HOME/sbin:$ZOOKEEPER_HOME/bin\n">>.bashrc
RUN apt-get install ssh
RUN cat /dev/zero | ssh-keygen -q -N ""
RUN sed '/<configuration>/a <name>dfs.namenode.name.dir</name>\n<value>/home/hadoop/data/namenode</value>\n</property>\n<property>\n<name>dfs.replication</name>\n<value>1</value>\n</property>\n<property>\n<name>dfs.permissions</name>\n<value>false</value>\n</property>\n<property>\n<name>dfs.nameservices</name>\n<value>ha-cluster</value>\n</property>\n<property>\n<name>dfs.ha.namenodes.ha-cluster</name>\n<value>namenode,standbynode</value>\n</property>\n<property>\n<name>dfs.namenode.rpc-address.ha-cluster.namenode</name>\n<value>namenode:9000</value>\n</property>\n<property>\n<name>dfs.namenode.rpc-address.ha-cluster.standbynode</name>\n<value>standbynode:9000</value>\n</property>\n<property>\n<name>dfs.namenode.http-address.ha-cluster.namenode</name>\n<value>namenode:50070</value>\n</property>\n<property>\n<name>dfs.namenode.http-address.ha-cluster.standbynode</name>\n<value>standbynode:50070</value>\n</property>\n<property>\n<name>dfs.namenode.shared.edits.dir</name>\n<value>qjournal://namenode:8485;standbynode:8485;datanode:8485/ha-cluster</value>\n</property>\n<property>\n<name>dfs.client.failover.proxy.provider.ha-cluster</name>\n<value>org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider</value>\n</property>\n<property>\n<name>dfs.ha.automatic-failover.enabled</name>\n<value>true</value>\n</property>\n<property>\n<name>ha.zookeeper.quorum</name>\n<value> namenode:2181,standbynode:2181,datanode:2181 </value>\n</property>\n<property>\n<name>dfs.ha.fencing.methods</name>\n<value>sshfence</value>\n</property>\n<property>\n<name>dfs.ha.fencing.ssh.private-key-files</name>\n<value>/root/.ssh/id_rsa</value>\n</property>"' >>/root/cluster/hadoop-2.6.0/etc/hadoop/hdfs-site.xml
RUN cd /root/cluster/zookeeper-3.4.6/conf
RUN cp zoo_sample.cfg zoo.cfg
RUN mkdir /root/cluster/zookeepder-data
RUN cd /root/cluster/zookeeper-3.4.6/conf
RUN echo "Server.1=nn1.cluster.com:2888:3888\nServer.2=nn2.cluster.com:2888:3888\nServer.3=dn1.cluster.com:2888:3888\n" >>zoo.cfg
EXPOSE 50070
