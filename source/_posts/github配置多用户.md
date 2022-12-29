---
title: github配置多用户
abbrlink: ef5df40e
date: 2022-12-08 12:18:46
tags:
---



因为需要使用多个github账号，但只有一台电脑，想要动态切换不同用户，并且做到免密提交。



# 环境

- Mac book Pro 2020
- git version 2.24.3 (Apple Git-128)
- github账号

| github登录账号        | github用户名 |
| --------------------- | ------------ |
| cnnqjban521@gmail.com | hoey94       |
| 351865576@qq.com      | hoey1994     |

- 测试用的项目(大小写区分)

| Github账号            | 项目 |
| --------------------- | ---- |
| cnnqjban521@gmail.com | Test |
| 351865576@qq.com      | test |



# 免密登录

为两个账号生成不同的公钥(*.pub)和密钥

```shell
ssh-keygen -t rsa -C "cnnqjban521@gmail.com" -f ~/.ssh/id_rsa_hoey94
ssh-keygen -t rsa -C "351865576@qq.com" -f ~/.ssh/id_rsa_hoey1994
```

生成的两组，公钥和密钥，分别到github官网上配置免密登录 Settings->SSH and GPG Keys->New SSH Key，填写的内容可以是用下面命令查看

```shell
cat ~/.ssh/id_rsa_hoey94.pub
cat ~/.ssh/id_rsa_hoey1994.pub
```



# 配置映射

创建~/.ssh/config，将内容填入进去

```shell
vim ~/.ssh/config

Host github-hoey1994
HostName github.com
IdentityFile ~/.ssh/id_rsa_hoey1994
```



这里解释一下这一组内容的含义，平常克隆的时候我们会这么写:

```shell
git clone git@github.com:hoey1994/test.git
```

但如果如果按照上面内容进行配置以后，在克隆的时候要改成这样：

```shell
git clone git@github-hoey1994:hoey1994/test.git
```

请仔细对比一下上面两个克隆命令之间的差异



按照同样原理，将另一个账号也配置一下

```shell
Host github-hoey94
HostName github.com
IdentityFile ~/.ssh/id_rsa_hoey94
```



> 如果端口有修改，可以按照下面的方式进行填写
>
> Host gitlib-juneyao
> HostName gitlab.juneyaoair.com
> Port 10022
> IdentityFile /Users/hoey/.ssh/id_rsa_juneyao



# 用户管理

推荐不要跳过这一步，gacm是管理git用户很不错的一个工具，可以稍微熟悉一下命令。对于commit 的author的信息，可以快速的进行切换，因为本地有多个用户，使用它可以大大提高效率。

1. 取消全局的用户配置

```shell
git config --global --unset user.email
git config --global --unset user.mail

# 可以查看内容是否已经取消
git config --global -e
```

2. 安装多用户管理工具[gacm](https://github.com/hoey94/gacm)，具体安装步骤见github

3. 使用gacm命令添加两个账户

```shell
gacm add --name hoey94 --email cnnqjban521@gmail.com
gacm add --name hoey1994 --email 351865576@qq.com
```



# 测试验证

在账号cnnqjban521@gmail.com(hoey94)下创建Test项目

在账号351865576@qq.com(hoey1994)下创建test项目

使用下面命令分别克隆到本地

```shell
# 克隆Test
git clone git@github-hoey94:hoey94/Test.git
# 使用gacm切换项目本地用户为hoey94
gacm use hoey94 --local
# 查看项目本地用户是否切换成功
gacm ls

# 克隆test
git clone git@github-hoey1994:hoey1994/test.git
# 使用gacm切换项目本地用户为hoey1994
gacm use hoey1994 --local
# 查看项目本地用户是否切换成功
gacm ls
```



改动一下里面的内容并提交完成测试。

