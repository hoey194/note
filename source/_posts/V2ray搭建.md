---
title: V2ray搭建
date: 2022-12-13 19:20:40
tags:
---



1. 登录vps

```shell
# CentOS：
bash <(curl -s -L https://git.io/v2ray.sh)
```



2.在出现的菜单选择界面，输入数字1回车，开始安装。

![image.png](http://tva1.sinaimg.cn/large/0066vfZIgy1h92en36veej30vy0bwn1g.jpg)

3.下面会让你选择V2ray的传输协议，可选协议众多，如果没什么特殊需求的话，默认TCP即可。如果你需要启用类似KCPTUN的网络加速功能，则选择mKCP开头的几个，在mKCP协议下，流量以UDP的形式传输。

![image.png](http://tva1.sinaimg.cn/large/0066vfZIgy1h92eo080wmj311o0xck91.jpg)

4.接下来分别需要选择：

V2ray端口：默认会给出一个端口，回车接受即可，或者也可以自定义。

广告拦截：一般不需要开启，大家可能更习惯浏览器自带的广告拦截。

是否配置Shadowsocks：如果需要同时安装Shadowsocks的话，选Y回车。建议安装，因为在V2ray出现无法连接的情况下，可以连接Shadowsocks用来判断是否服务器问题。

![image.png](http://tva1.sinaimg.cn/large/0066vfZIgy1h92eoswmgmj30oq0io0yr.jpg)

5.如果选择安装Shadowsocks，那么会依次要求设置端口、密码、加密协议，按提示设置即可。设置完成后回车键继续：

![image.png](http://tva1.sinaimg.cn/large/0066vfZIgy1h92epgcv0pj30t811sk5u.jpg)

6.接下来会提示配置完成，可以开始安装，这时按回车键继续：

![image.png](http://tva1.sinaimg.cn/large/0066vfZIgy1h92epx1rgrj30mg0hw7al.jpg)

7.安装完成后，会出现下图界面，提示刚才的各项配置信息，可以截图保存，以备后续客户端连接使用：提示：各项参数可以鼠标选择，选择成功后即自动复制。

![image.png](http://tva1.sinaimg.cn/large/0066vfZIgy1h92eqng8t9j311o0viaod.jpg)

8.现在可以使用V2ray客户端连接服务器了，连接成功后，就可以开始科学上网啦。



# V2Ray Mac客户端

V2RayU 下载地址：https://github.com/yanue/V2rayU/releases



# V2Ray IOS客户端

V2Ray IOS客户端有 Shadowrocket（小火箭）、Kitsunebi、Pepi 三款APP，但是目前均已从国区商店下架。可以网上搜一下有很多教程。可以给一个参考https://www.wangchao.info/1982.html



# V2Ray 安卓客户端 

https://github.com/2dust/v2rayNG/releases/
