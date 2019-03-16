# 安装 SBT

## 服务器已有SBT包安装方式
服务器文件 `/501_raid_common/developer/hadoop/spark/sbt-1.2.8.tgz` 压缩包有已经修改并编译好后的:
- sbt : sbt启动脚本
- sbt-launch.jar : sbt 启动jar包
 

1. 使用时可直接将该包解压到 `/usr/local` 目录
```
tar -xzvf /501_raid_common/developer/hadoop/spark/sbt-1.2.8.tgz -C /usr/local
```

1. 添加 sbt 环境变量 `vi /etc/profile` , 加入以下环境变量
```
export SBT="/usr/local/sbt"
export PATH="$PATH:$SBT_HOME/bin"
```

1. 生效 sbt 环境变量
```
source /etc/profile
```

1. 验证 sbt 
```
sbt sbt-version
```
这将会下载一些jar包
```
OpenJDK 64-Bit Server VM warning: ignoring option MaxPermSize=256M; support was removed in 8.0
Getting org.scala-sbt sbt 0.13.16  (this may take some time)...
downloading https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt/0.13.16/jars/sbt.jar ...
    [SUCCESSFUL ] org.scala-sbt#sbt;0.13.16!sbt.jar (4573ms)
downloading https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.10.6/scala-library-2.10.6.jar ...
    [SUCCESSFUL ] org.scala-lang#scala-library;2.10.6!scala-library.jar (12309ms)
......
[info] Resolving org.fusesource.jansi#jansi;1.4 ...
[info] Done updating.
[info] Set current project to lipengfei (in build file:/home/lipengfei/)
[info] 0.13.16
```

## 服务器无有SBT包安装方式
>参考 [Spark学习之手动安装sbt_CentOS 7](https://blog.csdn.net/weixin_42406021/article/details/81982776)

1. 下载[[1]](https://www.scala-sbt.org/0.13/docs/zh-cn/Installing-sbt-on-Linux.html) sbt-launch.jar : https://cocl.us/sbt01316tgz 
2. 由于墙的原因，最好换成 aliyun 的源头并重新打包 sbt-launch.jar
下载后解压进入 bin 目录, 解压 sbt-launch.jar
```
unzip -q ./sbt-launch.jar
```
修改配置文件
```
vim ./sbt/sbt.boot.properties
```
将 `[repositories]` 中的 `jcenter` 改为 `jcenter: http://maven.aliyun.com/nexus/content/groups/public/` 。如果没有 `jcenter`则添加。  
删除旧jar包
```
rm ./sbt-launch.jar   
```
修改完成后重新打包
```
jar -cfM ./sbt-launch.jar .   # 注意jar包名后面空一格后输入“.”
```

3. 创建脚本
```
cd /usr/local/sbt && touch ./sbt
cat <<EOM  > ./sbt
SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"
java $SBT_OPTS -jar /usr/local/sbt/sbt-launch.jar "$@"
EOM
chmod a+x ./sbt 
```

4. 验证sbt
```
./sbt sbt-version
```
这将会下载一些jar包
```
OpenJDK 64-Bit Server VM warning: ignoring option MaxPermSize=256M; support was removed in 8.0
Getting org.scala-sbt sbt 0.13.16  (this may take some time)...
downloading https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt/0.13.16/jars/sbt.jar ...
    [SUCCESSFUL ] org.scala-sbt#sbt;0.13.16!sbt.jar (4573ms)
downloading https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.10.6/scala-library-2.10.6.jar ...
    [SUCCESSFUL ] org.scala-lang#scala-library;2.10.6!scala-library.jar (12309ms)
......
[info] Resolving org.fusesource.jansi#jansi;1.4 ...
[info] Done updating.
[info] Set current project to lipengfei (in build file:/home/lipengfei/)
[info] 0.13.16
```


如果需要在所有用户下都可用就添加 sbt 环境变量 `vi /etc/profile` 

1. 加入以下环境变量
```
export SBT="/usr/local/sbt"
export PATH="$PATH:$SBT"
```

1. 生效 sbt 环境变量
```
source /etc/profile
```


# 参考
1. SBT官方下载 . https://www.scala-sbt.org/0.13/docs/zh-cn/Installing-sbt-on-Linux.html
1. Spark学习之手动安装sbt（CentOS 7）. https://blog.csdn.net/weixin_42406021/article/details/81982776