# 搭建大数据系统

环境 | 版本 
----- | ----- 
jdk  | open-jdk-1.8.0_181-b13
Hadoop | 2.7.7
HBase | 2.0.2

服务器 | 服务角色 | 服务组件
----- | ----- | ----- 
501-25  | hadoop master , hadoop slave ,  hbase master | NameNode , DataNode , SecondaryNameNode , NodeManager , ResourceManager
501-26  | hadoop slave , hbase RegionServer | DataNode , NodeManager


# 1. Hadoop HDFS
 1. [hadoop系统 自动部署搭建](./hadoop_auto/)

# 2. HBase
 1. [HBase 系统 自动部署搭建](./hbase/)