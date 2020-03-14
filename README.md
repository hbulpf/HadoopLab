# 搭建大数据系统

环境 | 版本 
----- | ----- 
jdk  | open-jdk-1.8.0_181-b13
Hadoop | 2.7.7
HBase | 2.0.2
Spark | 1.5.2

服务器 | 服务角色 | 服务组件
----- | ----- | ----- 
节点1  | Hadoop master , Hadoop slave <br>  HBase master <br>  Spark master, Spark worker| NameNode , DataNode , SecondaryNameNode , NodeManager , ResourceManager
节点2   | Hadoop slave <br> HBase RegionServer <br>  Spark worker | DataNode , NodeManager

![hadoop_arch.png](./pics/hadoop_arch.png)

# 1. Hadoop 
 1. [Hadoop 自动部署搭建](./hadoop_auto/)

# 2. HBase
 1. [HBase 系统 自动部署搭建](./hbase/)

# 3. Spark
 1. [Spark 系统 部署搭建](./spark/)