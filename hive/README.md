# 手动搭建 Hive

1. 下载安装Hive:  
    下载安装Hive
```
if [ ! -f /download/apache-hive-2.3.4-bin.tar.gz ]; then wget -O /download/apache-hive-2.3.4-bin.tar.gz http://mirrors.hust.edu.cn/apache/hive/hive-2.3.4/apache-hive-2.3.4-bin.tar.gz ; fi
tar -zxvf /download/apache-hive-2.3.4-bin.tar.gz -C /usr/local/hadoop/
```

2. 修改scala环境变量 `vi /etc/profile`
    添加如下内容:
```
export HIVE_HOME="/usr/local/hadoop/apache-hive-1.2.1-bin"
export PATH="$PATH:$HIVE_HOME/bin"
```
    生效环境变量
```
source /etc/profile
hive
```


# 参考
