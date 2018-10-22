#!/bin/bash
yum install nfs-utils -y #安装 nfs 软件包

# showmount -e 139.199.196.253   #查询远程NFS 服务端中可用的共享资源
if [[ ! -d /nfs_mirrors ]] ; then
    mkdir /nfs_mirrors   #创建挂载目录，并挂载 NFS共享目录 /sharedir
fi
mount -t nfs 139.199.196.253:/nfs_share /nfs_mirrors
echo "139.199.196.253:/nfs_share /nfs_mirrors nfs defaults 0 0" >>/etc/fstab #开机自动将共享目录挂载到本地