---
title: mac下的开发包管理工具-sdk
abbrlink: f1de28db
date: 2023-07-16 09:58:58
tags:
---



SDK可以帮助我们维护mac下的程序包，比如想安装jdk1.8、又想安装jdk11，比如想安装maven等等，它都可以通过指令进行安装和管理。下面是一些常用的指令：

```shell
# 安装
curl -s "https://get.sdkman.io" | bash
# 设置path
source "$HOME/.sdkman/bin/sdkman-init.sh"

# 查看sdk版本
sdk version
# 查看安装maven安装情况
sdk list maven

# 安装maven 3.6.4
sdk install maven  3.6.3
# maven被安装到的目录
cd ~/.sdkman/candidates
```
