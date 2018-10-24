cd /tmp && \
    wget -O hbase-2.0.2.tar.gz http://mirror.bit.edu.cn/apache/hbase/2.0.2/hbase-2.0.2-bin.tar.gz && \
    mkdir -p /usr/local/hadoop  && tar -xvzf hbase-2.0.2.tar.gz -C /usr/local/hadoop && \
    rm -y hbase-2.0.2.tar.gz 