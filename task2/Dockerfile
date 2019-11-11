FROM ubuntu:latest
WORKDIR /root
ENV HADOOP_HOME=/root/hadoop-2.9.2
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME HADOOP_COMMON_HOME=$HADOOP_HOME HADOOP_HDFS_HOME=$HADOOP_HOME YARN_HOME=$HADOOP_HOME HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre ZOOKEEPER_HOME=/root/apache-zookeeper-3.5.5
ENV PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$ZOOKEEPER_HOME/bin
RUN apt-get -y update && apt-get -y install openssh-client openssh-server openjdk-8-jdk vim net-tools && mkdir downloads namenode /tmp/zookeeper /home/journalnode datanode && chmod 755 datanode/ && service ssh start && wget https://www-eu.apache.org/dist/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz && tar -zxvf hadoop-2.9.2.tar.gz && wget https://www-eu.apache.org/dist/zookeeper/zookeeper-3.5.5/apache-zookeeper-3.5.5-bin.tar.gz && tar -zxvf apache-zookeeper-3.5.5-bin.tar.gz && mv apache-zookeeper-3.5.5-bin apache-zookeeper-3.5.5 && service ssh start && ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa && eval `ssh-agent -s` && ssh-add /root/.ssh/id_rsa && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && cd ~/.ssh && chmod 600 *
COPY hdfs-site.xml $HADOOP_CONF_DIR
COPY core-site.xml $HADOOP_CONF_DIR
COPY zoo.cfg $ZOOKEEPER_HOME/conf
EXPOSE 3888
EXPOSE 2888
EXPOSE 9000
EXPOSE 50070
EXPOSE 8445
EXPOSE 2181