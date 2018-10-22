#!/bin/bash
# install openssh-server, openjdk and wget
yum update -y && yum install -y openssh-server java-1.8.0-openjdk-devel wget

# install hadoop 2.7.2
# mkdir /tmp
cd /tmp && \
    wget -O hadoop-2.7.7.tar.gz http://mirror.bit.edu.cn/apache/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz && \
    mkdir -p /usr/local/hadoop  && tar -xvzf hadoop-2.7.7.tar.gz -C /usr/local/hadoop && \
    rm hadoop-2.7.7.tar.gz -y
# chmod a+x install_nfs_client.sh && ./install_nfs_client.sh
# mkdir -p /usr/local/hadoop && \
#     tar -xvzf /nfs_mirrors/hadoop/hadoop-2.7.7.tar.gz -C /usr/local/hadoop
