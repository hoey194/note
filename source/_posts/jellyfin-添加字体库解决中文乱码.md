---
title: Jellyfin 添加字体库解决中文乱码
abbrlink: ff462b52
date: 2023-04-30 13:35:03
tags:
---



最近使用Jellyfin搭建家庭影音出现中文乱码问题，下面是我搜到的一些方案，我用的是扩展中文字体库

* 使用nyanmisaka/jellyfin 套件
* 使用actime转字幕
* 扩展中文字体库



下面是一些指令，针对小白用的，大佬无视

```shell
# 远程登录到NAS并切换最高权限
ssh admin@192.168.30.5 -p 22
sudo -i

# 进入到NAS自己创建的目录，这个目录自己改
cd /volume1/media/fonts
pwd

# 使用docker命令查看jellyfin 的id
docker ps

# 进入到容器内部查看目录文件结构1538f09eaa85要替换成自己的id
docker exec -it 1538f09eaa85 /bin/bash
cd /usr/share/fonts/
exit

# 复制宿主机的文件到容器内
docker cp fz.tar.gz 1538f09eaa85:/usr/share/fonts/

# 到容器目录中解压
docker exec -it 1538f09eaa85 /bin/bash
cd /usr/share/fonts/
tar -zxvf fz.tar.gz

```

链接：https://share.weiyun.com/5Wg55FF5 密码：nhqe76



视频已经传到B站，欢迎观看[Jellyfin中文字幕乱码解决_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1jg4y1L7sR/?vd_source=8054953f896f7243d95be264ebdece29)

