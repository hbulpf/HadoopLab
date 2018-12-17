#!/bin/bash
# install openssh-server, openjdk and wget
yum update -y && yum install -y openssh-server java-1.8.0-openjdk-devel wget

# download hadoop 2.7.2
if [ ! -d /download ]; then
	mkdir -p /download
fi
if [ ! -f /download/hadoop-2.7.7.tar.gz ]; then
	wget -O /download/hadoop-2.7.7.tar.gz http://mirror.bit.edu.cn/apache/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
fi

# install hadoop 2.7.2
cd /download && \
    mkdir -p /usr/local/hadoop  && tar -xvzf hadoop-2.7.7.tar.gz -C /usr/local/hadoop
# chmod a+x install_nfs_client.sh && ./install_nfs_client.sh

useradd -d /home/hadoop -m hadoop
echo 'hadoop' | passwd --stdin hadoop
usermod -aG hadoop hadoop
sed -i "/^root/a\hadoop ALL = (ALL:ALL) NOPASSWD:ALL" /etc/sudoers
chown -R hadoop:hadoop /usr/local/hadoop/hadoop-2.7.7