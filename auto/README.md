# hadoop系统自动部署搭建
1. 在所有节点上修改hosts:   
修改 `updateHosts.sh` 中的主机名和IP为本地 hadoop 集群的主机名和IP，然后运行：
```
sh updateHosts.sh
```

2. 在所有节点上,安装 hadoop 运行如下命令
```
chmod a+x install_hadoop.sh install_nfs_client.sh test_hadoop.sh
./install_hadoop.sh
```

3. master节点免ssh验证登陆到其他节点
修改 `name_pwd` 文件，填入主机别名和主机的root密码(为了安全考虑，集群建好后可以将这个文件备份在其他地方，然后将该文件删除)，文件内容如下
```
hp_m_chunli cherry610.hcl
hp_s1_jianchuan huananshifan2015
hp_s2_bowei a13610025993
```

在 master 节点上运行
```
sh admin_set_ssh.sh
```

4. 修改 `config` 目录下 `hadoop` 的配置文件，如果无需额外配置，只需要替换 master 节点别名

5. 启动 hadoop 集群
在master节点运行
```
sh test_hadoop.sh
```
