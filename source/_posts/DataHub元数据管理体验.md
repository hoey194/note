---
title: DataHub元数据管理体验
abbrlink: 81a5898f
date: 2023-11-08 11:36:49
tags:
---

### Datahub



![image-20231108174154093](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20231108174154093.png)

**开源地址**：https://github.com/datahub-project/datahub 

DataHub是由Linkedin开源的，官方Slogan：The Metadata Platform for the Modern Data Stack - 为现代数据栈而生的元数据平台。目的就是为了解决多种多样数据生态系统的元数据管理问题，它提供元数据检索、数据发现、数据监测和数据监管能力，帮助大家解决数据管理的复杂性。

DataHub基于Apache License 2开源，采用基于推送的数据收集架构（当然也支持pull拉取的方式），能够持续收集变化的元数据。当前版本已经集成了大部分流行数据生态系统接入能力，包括但不限于：Kafka, Airflow, MySQL, SQL Server, Postgres, LDAP, Snowflake, Hive, BigQuery。

**Datahub的优点：**

* 名门开源，与Kafka同家庭。社区活跃，发展势头迅猛，版本更新迭代迅速。
* 定位清晰且宏远，Slogan可以看出团队的雄心壮志及后期投入，且不断迭代更新的版本也应证了这一点。
* 底层架构灵活先进，未扩展集成而生，支持推送和拉去模式，详见：https://datahubproject.io/docs/architecture/architecture/
* UI界面简单易用，技术人员及业务人员友好
* 接口丰富，功能全面

**Datahub的不足：**

* 前端界面不支持国际化，界面的构建和使用逻辑不够中国化
* 版更更新迭代快，使用后升级是个难题
* 较多功能在建设中，例如Hive列级血缘
* 部分功能性能还需要优化，例如SQL Profile
* 中文资料不多，中文交流社群也不多

**相关介绍**：

https://mp.weixin.qq.com/s/74gK3hTt7-j1lTbKFagbTQ
https://mp.weixin.qq.com/s/iP6sc2DzPaeAKpSWNmf8hQ

**选型建议**：

1）如果有至少半个前端开发人员+后台开发人员；
2）如果需要用户体验较好的数据资产管理平台；
3）如果有需要扩展支持各种平台、系统的元数据。请把Datahub列为最高选择。
尽管列举了一些不足，但是开源产品中Datahub目前是相对最好的选择。笔者也在生产中使用，有问题的可以随时沟通交流。

**商用版本**: Metaphor（https://metaphor.io/）是Datahub的SaaS版本。



### 部署及安装

1. 执行命令

```shell
python3 -m pip install --upgrade pip wheel setuptools
python3 -m pip install --upgrade acryl-datahub
datahub version
```

> ⚠️注: 在我们执行安装前，可以创建python虚拟环境



2. 从docker上拉取镜像部署，datahub提供了自动拉取镜像、自动部署节点的脚本，让部署一键操作

```shell
datahub docker quickstart
```

> ⚠️注: 如果你的网络不佳，或者是国内网络，过程会特别的漫长，我就是等了一天才好



成功后terminal中展示：

![image-20231108174029522](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20231108174029522.png)

下面我们登陆:

http://localhost:9002/login?redirect_uri=%2F

user/pass: datahub/datahub



![image-20231108174130857](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20231108174130857.png)

部署细节不懂的，可以参考: https://datahubproject.io/docs/quickstart



下一章我们结合Datahub API + 血缘解析工具，简单说一下怎么构建企业知识图谱
