# 手动搭建Spark

1. 下载安装scala和spark:  
    下载安装scala
```
if [ ! -f /download/scala-2.10.6.tgz ]; then wget -O /download/scala-2.10.6.tgz http://downloads.lightbend.com/scala/2.10.6/scala-2.10.6.tgz ; fi
tar -zxvf /download/scala-2.10.6.tgz -C /usr/local/hadoop/
```

    下载安装spark:
```
if [ ! -f /download/spark-1.5.2-bin-hadoop2.6.tgz ]; then wget -O /download/spark-1.5.2-bin-hadoop2.6.tgz http://archive.apache.org/dist/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz ; fi
tar -zxvf /download/spark-1.5.2-bin-hadoop2.6.tgz -C /usr/local/hadoop/
```
2. 修改scala环境变量 `vi /etc/profile`
    添加如下内容:
```
export SCALA_HOME="/usr/local/hadoop/scala-2.10.6"
export PATH="$PATH:$SCALA_HOME/bin"
```
    生效环境变量
```
source /etc/profile
scala -version
# Scala code runner version 2.10.6 -- Copyright 2002-2013, LAMP/EPFL
```

3. 修改spark环境变量 `vi /etc/profile`
添加如下内容:
```
export SPARK_HOME="/usr/local/hadoop/spark-1.5.2-bin-hadoop2.6"
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
1. [scala下载 . http://downloads.lightbend.com/scala/2.10.6/scala-2.10.6.tgz)
2. [spark 下载 . http://archive.apache.org/dist/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz)
3. [spark 安装参考指南 . https://blog.csdn.net/Noob_f/article/details/53425721)