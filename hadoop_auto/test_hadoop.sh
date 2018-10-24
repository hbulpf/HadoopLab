#!/bin/bash
# 测试 hadoop 集群
$HADOOP_HOME/bin/hadoop namenode -format
$HADOOP_HOME/bin/hadoop datanode -format
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh
jps