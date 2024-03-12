---
title: Marquez元数据管理体验
abbrlink: 4023ca29
date: 2023-11-08 11:11:19
tags:
---



### Marquez

![image-20231109105214566](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20231109105214566.png)

**开源地址**：https://github.com/MarquezProject/marquez 

**Marquez的优点：**

- 界面美观，操作细节设计比较棒
- 部署简单，代码简洁
- 依靠底层OpenLineage协议，结构较好

**Marquez的不足：**

- 聚焦数据资产/血缘的可视化，数据资产管理的一些功能，需要较多开发工作

**相关介绍**：https://mp.weixin.qq.com/s/OMm6QEk9-1bFdYKuimdxCw



## 安装及体验

1. 克隆项目

```shell
git clone git@github-hoey94:hoey94/marquez.git
```

2. 到项目根目录运行docker

```shell
DOCKER_BUILDKIT=1 ./docker/up.sh --seed
```

![image-20231108111436255](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20231108111436255.png)

3. 访问页面

![image-20231108113044028](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20231108113044028.png)

4. 简单实用

创建namespace

```shell
curl -X POST http://localhost:5000/api/v1/lineage \
-H 'Content-Type: application/json' \
-d '{
      "eventType": "START",
      "eventTime": "2020-12-28T19:52:00.001+10:00",
      "run": {
        "runId": "d46e465b-d358-4d32-83d4-df660ff614dd"
      },
      "job": {
        "namespace": "my-namespace",
        "name": "my-job"
      },
      "inputs": [{
        "namespace": "my-namespace",
        "name": "my-input"
      }],  
      "producer": "https://github.com/OpenLineage/OpenLineage/blob/v1-0-0/client"
    }'
```

创建input和output

```shell
curl -X POST http://localhost:5000/api/v1/lineage \
-H 'Content-Type: application/json' \
-d '{
      "eventType": "COMPLETE",
      "eventTime": "2020-12-28T20:52:00.001+10:00",
      "run": {
        "runId": "d46e465b-d358-4d32-83d4-df660ff614dd"
      },
      "job": {
        "namespace": "my-namespace",
        "name": "my-job"
      },
      "outputs": [{
        "namespace": "my-namespace",
        "name": "my-output",
        "facets": {
          "schema": {
            "_producer": "https://github.com/OpenLineage/OpenLineage/blob/v1-0-0/client",
            "_schemaURL": "https://github.com/OpenLineage/OpenLineage/blob/v1-0-0/spec/OpenLineage.json#/definitions/SchemaDatasetFacet",
            "fields": [
              { "name": "a", "type": "VARCHAR"},
              { "name": "b", "type": "VARCHAR"}
            ]
          }
        }
      }],     
      "producer": "https://github.com/OpenLineage/OpenLineage/blob/v1-0-0/client"
    }'
```

更多细节可以参考一下下面文章：https://blog.csdn.net/weixin_43947468/article/details/129593234

