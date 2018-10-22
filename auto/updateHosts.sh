#!/bin/bash
sed -i '18,$d' /etc/hosts
cat >>/etc/hosts <<EOM
# tencent hosts
119.29.13.35    git_zhangyu git.hnbd.cn
119.29.151.225  hp_m_chunli hpm.hnbd.cn
119.29.25.215   hp_s1_jianchuan hps1.hnbd.cn
119.29.91.143   hp_s2_bowei hps2.hnbd.cn
123.207.51.216  spider_zhuoyun  spider.hnbd.cn
139.199.190.25  xiaohong    
139.199.196.253 nfs_linjing nfs.hnbd.cn
193.112.214.70  pengcheng   
192.168.13.25  pxw501-25    50125.hnbd.cn
192.168.13.26  pxw501-26    50126.hnbd.cn
EOM
cat /etc/hosts