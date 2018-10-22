#!/bin/bash
ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 644 ~/.ssh/authorized_keys
#在admin节点上设置ssh登录信息
rm -rf ~/.ssh/config

set -x
set -v
while read line
do
    host=`echo $line | awk '{print $1}'`
    key=`echo $line | awk '{print $2}'` 
    printf "Host $host\n\tHostname  $host\n\tUser root\n" >> ~/.ssh/config  #向~/.ssh/config集群主机密钥配置
    #拷贝ceph-rc-1的密钥到其他节点，如果使用的是非root用户，在操作过程中，当需要root权限时会提示输入用户密码，这里使用root用户
    echo "sshpass -p $key ssh-copy-id -i ~/.ssh/id_rsa.pub root@$host" #向其他主机传输密钥
    sshpass -p $key ssh-copy-id -i ~/.ssh/id_rsa.pub root@$host #向其他主机传输密钥
done < name_pwd
set +x
set +v

chmod 644 ~/.ssh/config

exit 0