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

3. master节点免ssh验证登陆到其他节点
修改 `name_pwd` 文件，填入主机别名和主机的root密码(为了安全考虑，集群建好后可以将这个文件备份在其他地方，然后将该文件删除)。
在 master 节点上运行
```
sh admin_set_ssh.sh
```

4. 修改 `config` 目录下 `hadoop` 的配置文件，如果无需额外配置，只需要替换 master 节点别名

5. 启动 hadoop 集群
在master节点运行
```
$HADOOP_HOME/bin/hadoop namenode -format
$HADOOP_HOME/bin/hadoop datanode -format
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh
jps
```
