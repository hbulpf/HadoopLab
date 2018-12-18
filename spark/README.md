# spark系统手动搭建说明

1. 安装scala:  
tar -zxvf scala-2.10.6.tgz
mv scala-2.10.6 /usr/local/
2. 修改scala环境变量
vi /etc/profile
```
export SCALA_HOME=/usr/local/hadoop/scala-2.10.6
export PATH=$PATH:$SCALA_HOME/bin
```
source /etc/profile
scala -version
```
Scala code runner version 2.10.6 -- Copyright 2002-2013, LAMP/EPFL
```
3. 安装spark
tar -zxvf spark-1.5.2-bin-hadoop2.6.tgz
mv spark-1.5.2-bin-hadoop2.6 /usr/local/
4. 修改spark环境变量
vi /etc/profile
```
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HDFS_CONF_DIR=$HADOOP_HOME/etc/hadoop
export YARN_CONF_DIR==$HADOOP_HOME/etc/hadoop
export SPARK_HOME=/usr/local/hadoop/spark-1.5.2-bin-hadoop2.6
export PATH=$PATH:$SPARK_HOME/bin
export SPARK_CLASSPATH=$SPARK_HOME/lib/mysql-connector-java-5.1.46.jar
```
source /etc/profile
5. 修改spark配置文件
cp /usr/local/spark-1.5.2-bin-hadoop2.6/conf/slaves.template /usr/local/spark-1.5.2-bin-hadoop2.6/conf/slaves
vi /usr/local/spark-1.5.2-bin-hadoop2.6/conf/slaves
删除localhost，将内容改为
```
master
slave
```
6. 需要将mysql的驱动程序mysql-connector-java-5.1.46.jar拷贝到spark的lib目录中
7. 对26服务器进行以上同样操作
8. 启动 spark
切换到启动目录下，在master节点上运行
cd /usr/local/hadoop/spark-1.5.2-bin-hadoop2.6/sbin
```
./start-all.sh
sudo jps
```

9. http 网页访问
 - [访问 Spark master http页面, http://master:8080]

# 参考
1. [scala下载 . http://downloads.lightbend.com/scala/2.10.6/scala-2.10.6.tgz)
2. [spark 下载 . http://archive.apache.org/dist/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz)
3. [spark 安装参考指南 . https://blog.csdn.net/Noob_f/article/details/53425721)