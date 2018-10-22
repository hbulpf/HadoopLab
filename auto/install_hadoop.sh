#!/bin/bash
./install_nfs_client.sh
# install openssh-server, openjdk and wget
yum update -y && yum install -y openssh-server java-1.8.0-openjdk-devel wget

# install hadoop 2.7.2
# wget http://mirror.bit.edu.cn/apache/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
chmod a+x install_nfs_client.sh && ./install_nfs_client.sh
mkdir -p /usr/local/hadoop && \
    tar -xvzf /nfs_mirrors/hadoop/hadoop-2.7.7.tar.gz -C /usr/local/hadoop

# set environment variable
cat <<EOF >>/etc/profile
export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64"
export CLASSPATH=".:$JAVA_HOME/lib:$CLASSPATH"
export PATH="$PATH:$JAVA_HOME/bin"
export HADOOP_HOME="/usr/local/hadoop/hadoop-2.7.7"
export PATH="$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin"
export HADOOP_CONF_DIR="$HADOOP_HOME/etc/hadoop"
export YARN_CONF_DIR="$HADOOP_HOME/etc/hadoop"
EOF
source /etc/profile

# set hadoop config
cat <<EOF >>$HADOOP_HOME/etc/hadoop/hadoop-env.sh
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64
EOF
cat <<EOF >>$HADOOP_HOME/etc/hadoop/mapred-env.sh
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64
EOF
mkdir -p /data/hd2.7/hdfs/name && mkdir -p /data/hd2.7/hdfs/data && \
    mkdir -p /data/hd2.7/tmp && mkdir $HADOOP_HOME/logs

unalias cp
cp -rf /nfs_mirrors/hadoop/config/* $HADOOP_HOME/etc/hadoop/
alias cp='cp -i'