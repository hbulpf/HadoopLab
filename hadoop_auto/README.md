# hadoop系统自动部署搭建

1. 在所有节点上修改hosts:   
修改 `updateHosts.sh` 中的主机名和IP为本地 hadoop 集群的主机名和IP，然后运行：
```
chmod a+x updateHosts.sh
sh updateHosts.sh
```

2. 在所有节点上,安装 hadoop 运行如下命令
```
chmod a+x *
./install_hadoop.sh
```
运行下面的命令设置环境变量
```
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
cp -rf ./config/* "$HADOOP_HOME/etc/hadoop/"
alias cp='cp -i'
```

    修改 `config` 目录下 `hadoop` 的配置文件，如果无需额外配置，只需要替换 master 节点别名,并将修改好的 `config` 目录下的文件拷贝到服务器hadoop的安装目录下。
    ```
    cp -r ./config/* $HADOOP_HOME/etc/hadoop
    ```

4. master节点免ssh验证登陆到其他节点
修改 `name_pwd` 文件，填入主机别名和主机的root密码(为了安全考虑，集群建好后可以将这个文件备份在其他地方，然后将该文件删除)。<br>
`su hadoop`切换到 hadoop 用户下， 在 master 节点上运行
```
sh admin_set_ssh.sh
```

5. 启动 hadoop 集群<br>
`su hadoop`切换到 hadoop 用户下， 在 master 节点上运行
```
$HADOOP_HOME/bin/hadoop namenode -format
$HADOOP_HOME/bin/hadoop datanode -format
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh
jps
```

6. http 网页访问
 - [访问 Hadoop NameNode http页面, http://master:50070](http://50125.hnbdata.cn:50070)
 - [访问 Hadoop ResourceManager http页面, http://master:8088](http://50125.hnbdata.cn:8088/)
 - [访问 pxw501-26 Hadoop DataNode http页面, http://50126.hnbdata.cn:50075/](http://50126.hnbdata.cn:50075/)
 - [访问 pxw501-25 Hadoop DataNode http页面, http://50125.hnbdata.cn:50075/](http://50125.hnbdata.cn:50075/)


# 参考
1. [hbase下载 . http://hbase.apache.org/downloads.html](http://hbase.apache.org/downloads.html)
2. [Apache HBase 中文参考指南 . http://abloz.com/hbase/book.html#confirm](http://abloz.com/hbase/book.html#confirm)
3. [hadoop2.x常用端口及定义方法 . https://www.cnblogs.com/cxzdy/articles/4465472.html]()