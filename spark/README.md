# 手动搭建Spark

1. 下载安装scala和spark:  
    下载安装scala
```
if [ ! -f /download/scala-2.11.8.tgz ]; then wget -O /download/scala-2.11.8.tgz http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz ; fi
tar -zxvf /download/scala-2.11.8.tgz -C /usr/local/hadoop/
```

    下载安装spark:
```
if [ ! -f /download/spark-2.2.3-bin-hadoop2.7.tgz ]; then wget -O /download/spark-2.2.3-bin-hadoop2.7.tgz http://archive.apache.org/dist/spark/spark-2.1.0/spark-2.2.3-bin-hadoop2.7.tgz ; fi
tar -zxvf /download/spark-2.2.3-bin-hadoop2.7.tgz -C /usr/local/hadoop/
```
2. 修改scala环境变量 `vi /etc/profile`
    添加如下内容:
```
export SBT_HOME="/usr/local/sbt"
export PATH="$PATH:$SBT_HOME/bin"
```
    生效环境变量
```
source /etc/profile
scala -version
# Scala code runner version 2.11.8 -- Copyright 2002-2013, LAMP/EPFL
```

3. 修改spark环境变量 `vi /etc/profile`
添加如下内容:
```
export SPARK_HOME="/usr/local/hadoop/spark-2.2.3-bin-hadoop2.7"
export PATH="$PATH:$SPARK_HOME/bin"
export SPARK_CLASSPATH="$SPARK_HOME/lib/mysql-connector-java-5.1.46.jar"
```
 生效环境变量
```
source /etc/profile
```

4. 修改spark配置文件
```
cp $SPARK_HOME/conf/slaves.template $SPARK_HOME/conf/slaves
vi $SPARK_HOME/conf/slaves
```
删除localhost，将改为如下
```
pxw501-25
pxw501-26
```

```
cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh
vi $SPARK_HOME/conf/spark-env.sh
```
在后面加上这些配置
```
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-1.el7_6.x86_64
export SCALA_HOME=/usr/local/hadoop/scala-2.11.8
export HADOOP_HOME=/usr/local/hadoop/hadoop-2.7.7
export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop
export SPARK_MASTER_IP=pxw501-25
export SPARK_WORKER_MEMORY=4g
export SPARK_WORKER_CORES=2
export SPARK_WORKER_INSTANCES=1
export SPARK_WORKER_DIR=/data/hd2.7/spark/worker
```
参数解释
- JAVA_HOME：Java安装目录
- SCALA_HOME：Scala安装目录
- HADOOP_HOME：hadoop安装目录
- HADOOP_CONF_DIR：hadoop集群的配置文件的目录
- SPARK_MASTER_IP：spark集群的Master节点的ip地址
- SPARK_WORKER_MEMORY：每个worker节点能够最大分配给exectors的内存大小
- SPARK_WORKER_CORES：每个worker节点所占有的CPU核数目
- SPARK_WORKER_INSTANCES：每台机器上开启的worker节点的数目

**注意**：25,26服务器的 JAVA_HOME 不同

5. 需要将mysql的驱动程序mysql-connector-java-5.1.46.jar拷贝到spark的lib目录中
```
cp ./mysql-connector-java-5.1.46.jar $SPARK_HOME/lib/
```
6. 对非master节点进行以上同样操作
7. 启动 spark
在master节点上运行
```
$SPARK_HOME/sbin/start-all.sh
sudo jps
```

8. http 网页访问
 - [访问 Spark master http页面, http://50125.hnbdata.cn:8080/](http://50125.hnbdata.cn:8080)
 - [访问 Spark Jobs http页面, http://50125.hnbdata.cn:4040/jobs/](http://50125.hnbdata.cn:4040/jobs/)
 - [访问 Spark作业 http页面, http://50125.hnbdata.cn:8088](http://50125.hnbdata.cn:8088)


# 参考
1. scala下载 . http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz
2. spark 下载 . http://archive.apache.org/dist/spark/spark-2.1.0/spark-2.2.3-bin-hadoop2.7.tgz
3. spark 安装参考指南 . https://blog.csdn.net/Noob_f/article/details/53425721