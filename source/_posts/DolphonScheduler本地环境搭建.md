---
title: DolphonScheduler本地环境搭建
date: 2022-12-28 22:29:17
tags:
---



环境准备

- [Git](https://git-scm.com/downloads)
- [JDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html): v1.8.x (Currently does not support jdk 11)
- [Maven](http://maven.apache.org/download.cgi): v3.5+
- [Node](https://nodejs.org/en/download): v16.13+ (dolphinScheduler version is lower than 3.0, please install node v12.20+)
- [Pnpm](https://pnpm.io/installation): v6.x



1. 克隆项目到本地

```shell
git clone https://github.com/apache/dolphinscheduler.git
```

2. 导入项目到IDEA，并切换分支到``3.1.0``

```shell
git checkout 3.1.0-release
```

3. 编译项目

```shell
./mvnw spotless:apply 
./mvnw clean install -Prelease -Dmaven.test.skip=true
```

> spotless是一种代码格式化工具，使用 spotless:apply 表示开启module代码格式校验
>
> mvnw同mvn的功能是一样的，mvnw做了项目适配

4. 创建database数据库

```sql
CREATE SCHEMA dolphinschedulertest;
```

5. 修改项目配置文件

全局进行搜索``application.yaml``，将文件中涉及postgresql的替换为myslq

```shell
    #    driver-class-name: org.postgresql.Driver
    #    url: jdbc:postgresql://127.0.0.1:5432/dolphinscheduler
    #    username: root
    #    password: root
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://127.0.0.1:3306/dolphinschedulertest
    username: root
    password: 123456
    
    org.quartz.jobStore.driverDelegateClass: org.quartz.impl.jdbcjobstore.StdJDBCDelegate
```

6. 修改dolphinscheduler-bom下pom.xml

```xml
 <dependency>
   <groupId>mysql</groupId>
   <artifactId>mysql-connector-java</artifactId>
   <version>${mysql-connector.version}</version>
   <scope>compile</scope>
 </dependency>
```

7. 修改logback-spring.xml

全局搜索logback-spring.xml，将下面内容添加到其中

```xml
<root level="INFO">
  <!--将这句话加入到root节点下-->
	<appender-ref ref="STDOUT"/> 
</root>
```

8. 配置启动项

分别配置MasterServer, WorkerServer, ApiApplicationServer

- MasterServer：主类 `org.apache.dolphinscheduler.server.master.MasterServer`  *VM Options* `-Dlogging.config=classpath:logback-spring.xml -Ddruid.mysql.usePingMethod=false -Dspring.profiles.active=mysql`
- WorkerServer：主类 `org.apache.dolphinscheduler.server.worker.WorkerServer`  *VM Options* `-Dlogging.config=classpath:logback-spring.xml -Ddruid.mysql.usePingMethod=false -Dspring.profiles.active=mysql`
- ApiApplicationServer：主类 `org.apache.dolphinscheduler.api.ApiApplicationServer`  *VM Options* `-Dlogging.config=classpath:logback-spring.xml -Dspring.profiles.active=api,mysql`. 

9. 配置zookeeper

zookeeper部署[详情](https://blog.hoey.tk/2018/04/15/2018-04-15-hadoop-zookeeper%E9%9B%86%E7%BE%A4%E6%90%AD%E5%BB%BA%E5%8F%8A%E5%85%B6%E4%BD%BF%E7%94%A8/)

10. 启动前端

```shell
pnpm install
pnpm run dev
```

11. 启动后端

分别运行MasterServer, WorkerServer, ApiApplicationServer
