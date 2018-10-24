# HBase系统自动部署搭建
0. 先安装好Hadoop
1. 运行下面的命令设置环境变量
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
