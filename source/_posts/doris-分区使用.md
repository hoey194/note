---
title: doris 分区使用
abbrlink: 30c459fa
date: 2024-02-06 10:15:18
tags:
---



下面是一个简单的小例子

```sql
drop table test.t1;
create table test.t1(
    dt DATE,
    name varchar(32)
) ENGINE=OLAP
DUPLICATE KEY(dt)
PARTITION BY RANGE(dt)()
DISTRIBUTED BY HASH(dt) BUCKETS auto
PROPERTIES (
"replication_allocation" = "tag.location.default: 3",
"dynamic_partition.enable" = "true",
"dynamic_partition.time_unit" = "DAY",
"dynamic_partition.time_zone" = "Asia/Shanghai",
"dynamic_partition.prefix" = "p",
"dynamic_partition.start" = "-30",
"dynamic_partition.end" = "3",
"is_being_synced" = "false",
"storage_format" = "V2",
"light_schema_change" = "true",
"disable_auto_compaction" = "false",
"enable_single_replica_compaction" = "false"
);


insert into test.t1
select date '2024-02-07' as dt, 'zs' as name ;

-- alter table test.t1 add partition if not exists p20240131 values[('2024-01-31'),('2024-02-01'));
-- TRUNCATE TABLE test.t1  PARTITION(p20240207);
-- show partitions FROM test.t1;
select * from test.t1 where dt = '2024-02-06';
```



