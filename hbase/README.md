# HBase 系统自动部署搭建
0. 先安装好Hadoop
1. 在所有节点上,安装 HBase 运行如下命令
```
chmod a+x install_hbase.sh
./install_hbase.sh
```
2. 运行下面的命令设置环境变量
```
# set environment variable
cat <<EOF >>/etc/profile
export HBASE_HOME="/usr/local/hadoop/hbase-2.0.2"
export PATH="$PATH:$HBASE_HOME/bin"
EOF
source /etc/profile
# set hbase config
cat <<EOF >>$HBASE_HOME/conf/hbase-env.sh
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64
EOF
mkdir -p /data/hbase2.0.2/tmp
unalias cp
cp -rf ./conf/* "$HBASE_HOME/conf/"
alias cp='cp -i'
```

3. 启动 HBase 集群
在master节点运行
```
$HBASE_HOME/bin/start-hbase.sh
```

4. http 网页访问
 - [访问 Hbase Master http页面,http://master:60010](http://50125.hnbdata.cn:60010)
 - [访问 Hbase RegionServer http页面,http://regionServe1:60030](http://50126.hnbdata.cn:60030)

# 参考
1. [hbase下载 . http://hbase.apache.org/downloads.html](http://hbase.apache.org/downloads.html)
2. [Apache HBase 中文参考指南 . http://abloz.com/hbase/book.html#confirm](http://abloz.com/hbase/book.html#confirm)

# 常见问题
1. HBase 与 Hadoop 的 jar 包冲突,如下
错误如下；
```
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hadoop/hbase-2.0.2/lib/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop/hadoop-2.7.7/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
```
解决办法:
将HBase的jar包修改名称(最好不要删除)
```
mv usr/local/hadoop/hbase-2.0.2/lib/slf4j-log4j12-1.7.25.jar /usr/local/hadoop/hbase-2.0.2/lib/slf4j-log4j12-1.7.25.jar-bak
```