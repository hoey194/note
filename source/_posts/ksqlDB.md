---
title: ksqlDB
abbrlink: f30a9b25
date: 2023-03-14 16:16:12
tags:
---

目前需要对Kafka Topic中的数据进行分析，查询了一下KSQLDB挺不错，它是一个流处理引擎，主要用于处理实时数据流，并支持 SQL 查询和流处理操作。KSQLDB 可以运行在 Apache Kafka 平台之上，它不需要额外的基础设施，因此可以方便地与 Kafka 进行集成。KSQLDB 可以实现流数据的可视化、数据的清洗和去重、流式计算等。KSQLDB 的主要特点包括易于使用、接近实时的处理速度、强大的 SQL 查询功能以及灵活的流处理操作。



环境准备

- MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)
- Docker & Docker compose



下面代码用于部署Standalone

```dockerfile
---
version: '2'

services:
  zookeeper:
    image: confluentinc/cp-zookeeper:7.3.0
    hostname: zookeeper
    container_name: zookeeper
    ports:
      - "2181:2181"
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_TICK_TIME: 2000

  broker:
    image: confluentinc/cp-kafka:7.3.0
    hostname: broker
    container_name: broker
    depends_on:
      - zookeeper
    ports:
      - "29092:29092"
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: 'zookeeper:2181'
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://broker:9092,PLAINTEXT_HOST://localhost:29092
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
      KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS: 0
      KAFKA_TRANSACTION_STATE_LOG_MIN_ISR: 1
      KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR: 1

  ksqldb-server:
    image: confluentinc/ksqldb-server:0.28.3
    hostname: ksqldb-server
    container_name: ksqldb-server
    depends_on:
      - broker
    ports:
      - "8088:8088"
    environment:
      KSQL_LISTENERS: http://0.0.0.0:8088
      KSQL_BOOTSTRAP_SERVERS: broker:9092
      KSQL_KSQL_LOGGING_PROCESSING_STREAM_AUTO_CREATE: "true"
      KSQL_KSQL_LOGGING_PROCESSING_TOPIC_AUTO_CREATE: "true"

  ksqldb-cli:
    image: confluentinc/ksqldb-cli:0.28.3
    container_name: ksqldb-cli
    depends_on:
      - broker
      - ksqldb-server
    entrypoint: /bin/sh
    tty: true
```

启动KsqlDB服务:

```shell
docker-compose up
```

使用Docker链接到Cli中

```shell
docker exec -it ksqldb-cli
```

链接到cli中后，在终端运行命令链接：

```shell
[ksqldb-cli] docker exec -it ksqldb-cli ksql http://ksqldb-server:8088
```

可以运行命令查看topic

```shell
show topics;
```

如果你想链接远端Kafka集群，将<KSQL_BOOTSTRAP_SERVERS> 替换成自己的远程Kafka集群，像下面这个dockerfile一样：

```dockerfile
---
version: '2'

services:

  ksqldb-server-juneyao:
    image: confluentinc/ksqldb-server
    hostname: ksqldb-server-juneyao
    container_name: ksqldb-server-juneyao
    ports:
      - "8088:8088"
    environment:
      KSQL_LISTENERS: http://0.0.0.0:8088
      KSQL_BOOTSTRAP_SERVERS: 172.22.17.28:9092
      KSQL_KSQL_LOGGING_PROCESSING_STREAM_AUTO_CREATE: "true"
      KSQL_KSQL_LOGGING_PROCESSING_TOPIC_AUTO_CREATE: "true"

  ksqldb-cli-juneyao:
    image: confluentinc/ksqldb-cli
    container_name: ksqldb-cli-juneyao
    depends_on:
      - ksqldb-server-juneyao
    entrypoint: /bin/sh
    tty: true
```

 后面的操作和上面都一样了，启动的时候注意修改名称

![image-20230314162231259](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20230314162231259.png)



### Example 1： 创建流表并查询

展示有多少Topic:

```sql
show topics;
show streams;
```

在cli链接后，我们创建一个riderLocations流，如果locations这个topic在kafka中不存在，则会对应创建。

```sql
CREATE STREAM riderLocations (
    profileId VARCHAR,
    latitude  DOUBLE,
    longitude DOUBLE
) WITH ( kafka_topic='locations', value_format='json', PARTITIONS =1 );
```

然后往topic中插入一批数据

```shell
kafka-console-producer --broker-list localhost:9092 --topic locations 
{"profileId":"1","latitude":2.0,"longitude":1.0}
{"profileId":"2","latitude":3.0,"longitude":3.0}
{"profileId":"3","latitude":1.0,"longitude":1.0}
```

就可以愉快的查询它了

```sql
SET 'auto.offset.reset'='earliest';
select * from riderLocations;
```

更多的详细用法可以参考网站[ksqldb](https://ksqldb.io/quickstart.html#quickstart-content)

