---
title: >-
  Doris写入数据异常提示actual column number in csv file is less than schema column
  number
abbrlink: 5cb58a30
date: 2024-03-12 11:00:19
tags:
---



Flink 写入Doris报错

```
Reason: actual column number in csv file is  less than  schema column number.actual number: 34, column separator: [	], line delimiter: [].......
```



通过去掉列中的换行和回车，修正了部分问题

原格式：

```sql
select 
VERSION_J as VERSION_J
from t
```

修改后:

```sql
select 
REGEXP_REPLACE(coalesce(VERSION_J, ''),'CHAR(13)|CHAR(10)|\r|\n','') as VERSION_J
from t
```



