---
title: DolphonScheduler 3.1.0 本地环境搭建
date: 2022-12-28 22:29:17
tags:
---



环境准备

- MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)
- [Git](https://git-scm.com/downloads)
- [JDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html): v1.8.x (Currently does not support jdk 11)
- [Maven](http://maven.apache.org/download.cgi): v3.5+
- [Node](https://nodejs.org/en/download): v16.13+ (dolphinScheduler version is lower than 3.0, please install node v12.20+)
- [Pnpm](https://pnpm.io/installation): v6.x



1.克隆项目到本地

```shell
git clone https://github.com/apache/dolphinscheduler.git
```

2.导入项目到IDEA，并切换分支到``3.1.0``

```shell
git checkout 3.1.0-release
```

3.编译项目

spotless是一种代码格式化工具，使用 spotless:apply 表示开启module代码格式校验

mvnw同mvn的功能是一样的，mvnw做了项目适配

```shell
./mvnw spotless:apply 
./mvnw clean install -Prelease -Dmaven.test.skip=true
```

4.在mysql创建database数据库

```sql
CREATE SCHEMA dolphinschedulertest;
```

5.修改项目配置文件

全局搜索``application.yaml``，将文件中涉及postgresql的替换为mysql

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

6.修改dolphinscheduler-bom下pom.xml

```xml
 <dependency>
   <groupId>mysql</groupId>
   <artifactId>mysql-connector-java</artifactId>
   <version>${mysql-connector.version}</version>
   <scope>compile</scope>
 </dependency>
```

7.修改logback-spring.xml

全局搜索logback-spring.xml，将下面内容添加到其中

```xml
<root level="INFO">
  <!--将这句话加入到root节点下-->
	<appender-ref ref="STDOUT"/> 
</root>
```

8.配置启动项

分别配置MasterServer, WorkerServer, ApiApplicationServer

- MasterServer：Execute function `main` in the class `org.apache.dolphinscheduler.server.master.MasterServer` by Intellij IDEA, with the configuration *VM Options* `-Dlogging.config=classpath:logback-spring.xml -Ddruid.mysql.usePingMethod=false -Dspring.profiles.active=mysql`
- WorkerServer：Execute function `main` in the class `org.apache.dolphinscheduler.server.worker.WorkerServer` by Intellij IDEA, with the configuration *VM Options* `-Dlogging.config=classpath:logback-spring.xml -Ddruid.mysql.usePingMethod=false -Dspring.profiles.active=mysql`
- ApiApplicationServer：Execute function `main` in the class `org.apache.dolphinscheduler.api.ApiApplicationServer` by Intellij IDEA, with the configuration *VM Options* `-Dlogging.config=classpath:logback-spring.xml -Dspring.profiles.active=api,mysql`. After it started, you could find Open API documentation in http://localhost:12345/dolphinscheduler/swagger-ui/index.html

9.配置zookeeper

参考以前的博客[zookeeper部署](https://blog.hoey.tk/2018/04/15/2018-04-15-hadoop-zookeeper%E9%9B%86%E7%BE%A4%E6%90%AD%E5%BB%BA%E5%8F%8A%E5%85%B6%E4%BD%BF%E7%94%A8/)

10.启动前端

```shell
pnpm install
pnpm run dev
```

11.启动后端

分别在IDEA中运行MasterServer, WorkerServer, ApiApplicationServer



登陆账号密码 <font color="red">admin/dolphinscheduler123</font>

参考文档：https://www.bookstack.cn/read/dolphinscheduler-3.1.0-en/af18cd17a04eb31f.md
