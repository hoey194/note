---
title: Doris使用踩坑总结
abbrlink: f144fb4b
date: 2023-03-28 12:51:12
tags:
---

环境

- MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)
- [Doris]([部署 Docker 集群 - Apache Doris](https://doris.apache.org/zh-CN/docs/dev/install/construct-docker/run-docker-cluster/)):v1.12.1
- [JDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html): v1.8.x
- IDEA开发环境



### 一、 Docker部署

官方提供文档[Deploy Docker cluster](https://doris.apache.org/zh-CN/docs/dev/install/construct-docker/run-docker-cluster/)

<font color="red">但部署完以后发现集群无法识别BE节点，查看日志发现是因为没有设置``vm.max_map_count``参数</font>

> 避坑1: 需要设置sysctl -w vm.max_map_count=2000000
>
> 避坑2: 在启动容器时需要添加privileged: true



### 二、Flink 写入Doris

官方提供了文档[Flink Doris Connector](https://doris.apache.org/zh-CN/docs/dev/ecosystem/flink-doris-connector?_highlight=flink)

这里选用的是RowData的方式写入到Doris，提前到Doris中创建表代码如下:

```sql
CREATE DATABASE dwd;
DROP TABLE IF EXISTS dwd.TICKET;
CREATE TABLE IF NOT EXISTS dwd.TICKET (
        event VARCHAR(256),
        newval VARCHAR(256),
        oldval VARCHAR(256),
        stamp VARCHAR(256),
        subevent VARCHAR(256),
        uptm VARCHAR(256),
        uptmms VARCHAR(256),
        ver VARCHAR(256)
)DISTRIBUTED BY HASH(stamp) BUCKETS 1
PROPERTIES (
"replication_allocation" = "tag.location.default: 1"
);
```

然后是使用Java代码:

```java
public static void main(String[] args) throws Exception {

        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);
        Properties prop = new Properties();
        prop.setProperty("format", "json");
        prop.setProperty("strip_outer_array", "true");

        env.fromElements("{\"event\":\"CheckIn\",\"newval\":\"90\",\"oldval\":\"0\",\"stamp\":\"67100c4f-0355-4dba-8a76-2a94202132d1\",\"subevent\":\"\",\"uptm\":\"20230319094822\",\"uptmms\":\"20230319094822031\",\"ver\":\"v1.0\"}")
                .addSink(DorisSink.sink(
                        DorisReadOptions.builder().build(),
                        DorisExecutionOptions.builder().setBatchSize(3)
                                .setBatchIntervalMs(0L)
                                .setMaxRetries(3)
                                .setStreamLoadProp(prop)
                                .build(),
                        DorisOptions.builder().setFenodes("localhost:8030")
                                .setTableIdentifier("dwd.TICKET")
                                .setUsername("admin")
                                .setPassword("").build())
                );
        env.execute("pss-format-job");
}
```

<font color="red">运行时发现网络不通问题，无法成功写入Dois</font>，具体错误如图下图所示：

![image-20230328131103501](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20230328131103501.png)

分析宿主节点和docker集群的关系

![image-20230328131607049](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20230328131607049.png)

由架构图得知，是因为sink写入的时候通过外网地址的fe取到be地址是内网地址。

解决思路：

1. 程序上传到FE运行，但是我属于本地开发环境，这种方式不适合
2. 配置Docker network，使得在宿主节点能够访问容器 BE的IP。这块我也尝试搜索了很多资料，最终以失败告终。

	- 尝试一： 在宿主节点修改路由表 sudo route add -net 172.20.80.0/24 172.20.80.1
	- 尝试二： 以Host方式运行FE和BE

3. 修改源代码： 找到涉及到“第二步：将BE内网IP返回给主程序”代码，并修改

其中我是用第三种方法，成功在本地开发环境摄入数据到Doris，在这里简单介绍一下快速修改源码的方法。



第一步： 先找到涉及到代码的相关方法，在该场景中对应的是``org.apache.doris.flink.rest.RestService``类的``randomBackend()``。

```java
@VisibleForTesting
    public static String randomBackend(DorisOptions options, DorisReadOptions readOptions, Logger logger) throws DorisException, IOException {
        List<BackendRowV2> backends = getBackendsV2(options, readOptions, logger);
        logger.trace("Parse beNodes '{}'.", backends);
        if (backends != null && !backends.isEmpty()) {
            Collections.shuffle(backends);
            BackendRowV2 backend = (BackendRowV2)backends.get(0);
            return backend.getIp() + ":" + backend.getHttpPort();
        } else {
            logger.error("argument '{}' is illegal, value is '{}'.", "beNodes", backends);
            throw new IllegalArgumentException("beNodes", String.valueOf(backends));
        }
    }
```

第二步：现在希望返回值并非BE的内网IP，因此我们需要将``return``的内容写死```return "localhost:8040";```

第三步：在代码中我们创建与类相同的包，并将源码原封不动粘贴进去，如果报错，可以修改。紧接着修改```return "localhost:8040";```即可

![image-20230328133408579](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20230328133408579.png)





总结：

我这里是本地开发环境遇到的问题，并非生产环境；如果生产环境部署基于Doris的应用程序，则需要注意下下面几点：

1. 运行的代码所在的机器，必须与Doris所在的网络保持通常。
2. 基于RowData的摄入方式不太友好，现在仍要寻找一种更好的编码方式。
