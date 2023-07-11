---
title: Docker中部署单节点Hadoop
abbrlink: edf97c6c
date: 2023-07-05 15:05:12
tags:
---



之前介绍了Docker中部署多节点集群见链接[Docker部署多节点Hadoop](https://blog.hoey.tk/2020/11/15/2020%E5%B9%B411%E6%9C%8815%E6%97%A514:11:53_%E4%BD%BF%E7%94%A8docker%E9%83%A8%E7%BD%B2hadoop/)

在开发环境中，单节点的集群用来做验证还是十分方便的，下面介绍一下部署单节点的Hadoop集群。



### 创建自定义网络

```shell
# 创建自定义网络 

# ip段为：192.168.10.1/24，名字为：hadoop
docker network create --subnet=192.168.10.1/24 hadoop
# 显示自定义网络列表
docker network ls
```



### 创建容器

创建容器时，开放端口8088（Yarn）、9000（HDFS通信端口，新版本时8020）、50010（数据传输端口）、50075（web页面下载文件端口）

```shell
docker run --name hadoop-standalone \
--hostname hadoop-standalone \
--net hadoop --ip 192.168.10.9 \
-p 50070:50070 \
-p 8088:8088 \
-p 9000:9000 \
-p 8020:8020 \
-p 50010:50010 \
-p 50075:50075 \
-d -P ryaning/hadoop
```



如果你想将上文中创建的hadoop0、hadoop1、hadoop2节点也加入到网络组，可一用下面命令

```shell
docker run --name hadoop-standalone \
--hostname hadoop-standalone \
--net hadoop --ip 192.168.10.9 \
--add-host hadoop0:192.168.10.10 \
--add-host hadoop1:192.168.10.11 \
--add-host hadoop2:192.168.10.12 \
-p 50070:50070 \
-p 8088:8088 \
-p 9000:9000 \
-p 8020:8020 \
-p 50010:50010 \
-p 50075:50075 \
-d -P ryaning/hadoop
```



### 设置 SSH 免密码登录

```shell
# 进入容器内
docker exec -it hadoop-standalone bash

# 执行后会有多个输入提示，不用输入任何内容，全部直接回车即可
ssh-keygen

# 执行命令后需要输入登录密码，**默认为 123456**
ssh-copy-id -i /root/.ssh/id_rsa -p 22 root@hadoop-standalone
```



###  修改 Hadoop 配置文件

- hadoop-env.sh

```shell
export JAVA_HOME=/usr/local/jdk1.8
```

- yarn-env.sh

```shell
export JAVA_HOME=/usr/local/jdk1.8
```

- core-site.xml

```shell
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://hadoop-standalone:9000</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/usr/local/hadoop/tmp</value>
    </property>
     <property>
         <name>fs.trash.interval</name>
         <value>1440</value>
    </property>
</configuration>
```

- hdfs-site.xml

```shell
<configuration>
	<property>
        <name>dfs.datanode.use.datanode.hostname</name>
        <value>true</value>
	</property>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.permissions</name>
        <value>false</value>
    </property>
</configuration>
```

- yarn-site.xml

```shell
<configuration>
    <property>
       <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
```

这个文件默认不存在，需要从 mapred-site.xml.template 复制过来

```shell
mv mapred-site.xml.template mapred-site.xml
```

```shell
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
```

### 初始化

```shell
hdfs namenode -format
```

### 启动 hadoop 集群

```shell
# /usr/local/hadoop 目录下执行
sbin/start-all.sh
```



### 测试验证

创建本地测试文件，在 /opt 目录下创建测试文件目录。

```shell
mkdir wcinput
cd wcinput
vi wc.input
```

wc.input文件内容如下：

```shell
hadoop mapreduce
hadoop yarn
hadoop hdfs
mapreduce spark
hadoop hello
```

创建 HDFS 目录

```shell
hdfs dfs -mkdir -p /user/hadoop/input
```

上传文件，把测试文件上传到刚刚创建的目录中

```shell
hdfs dfs -put /opt/wcinput/wc.input /user/hadoop/input
```

查看文件上传是否正确

```shell
hdfs dfs -ls /user/hadoop/input
[root@hadoop0 wcinput]# hdfs dfs -ls /user/hadoop/input
Found 1 items
-rw-r--r--   1 root supergroup         70 2019-01-21 10:07 /user/hadoop/input/wc.input
[root@hadoop0 wcinput]#
```

运行 mapreduce 程序

hadoop 安装包中提供了一个示例程序，我们可以使用它对刚刚上传的文件进行测试

```shell
hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.9.2.jar wordcount /user/hadoop/input /user/hadoop/output
```

> 注：在执行过程中，如果长时间处于 Running 状态不动，虽然没有报错，但实际上是出错了，后台在不断重试，需要到 logs 目录下（/usr/local/hadoop/logs）查看日志文件中的错误信息。

查看输出结果

```shell
hdfs dfs -ls /user/hadoop/output
[root@hadoop0 wcinput]# hdfs dfs -ls /user/hadoop/output
Found 2 items
-rw-r--r--   1 root supergroup          0 2019-01-22 05:35 /user/hadoop/output/_SUCCESS
-rw-r--r--   1 root supergroup         51 2019-01-22 05:35 /user/hadoop/output/part-r-00000
```

_SUCCESS 表示 HDFS 文件状态，生成的结果在 part-r-00000 中查看。

```shell
hdfs dfs -cat /user/hadoop/output/part-r-00000
[root@hadoop0 wcinput]# hdfs dfs -cat /user/hadoop/output/part-r-00000
hadoop    4
hdfs    1
hello    1
mapreduce    2
spark    1
yarn    1
[root@hadoop0 wcinput]#
```

以上就是使用 Docker 环境搭建 Hadoop 镜像容器，配置 Hadoop 集群，并启动和测试的实例，测试用的是 hadoop 官方给的一个 wordcount 统计，利用 hadoop 安装包里的 mapreduce 示例 jar 计算指定 HDFS 文件里的单词数，并将结果输出到指定 HDFS 目录。后面会介绍 HDFS 常用文件操作命令。
