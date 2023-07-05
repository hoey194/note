---
title: 使用反向代理解决SSL认证
abbrlink: a6b71998
date: 2023-05-04 20:55:42
tags:
---

自己手里有很多私有服务，并且域名还都不一样，例如下面这些：

| 应用     | ip                |
| -------- | ----------------- |
| NAS      | 192.168.30.5:5000 |
| Jellyfin | 192.168.30.5:8096 |
| 私人笔记 | hoey94.github.io  |
| 私人网盘 | 192.168.30.5:9000 |
| chatgpt  | chat.github.io    |
| ...      | ...               |

这些应用管理起来十分不方便，于是就想将这些网站整合在一起，并且对外提供统一域名访问方式。我自身是有一个免费的顶级域名的hoey.tk，那现在的需求就很明确了，其实就是想得到下面这样的效果：

| 应用     | ip               |
| -------- | ---------------- |
| NAS      | nas.hoey.tk      |
| Jellyfin | jellyfin.hoey.tk |
| 私人笔记 | notes.hoey.tk    |
| 私人网盘 | pan.hoey.tk      |
| chatgpt  | chat.hoey.tk     |
| ...      | ...              |

最近找到了一款挺不错的软件[Nginx Project Manager](https://github.com/NginxProxyManager/nginx-proxy-manager)，并且还能提供免费的SSL，虽然3个月到期以后还要手动续期，不过白嫖的东西还要什么自行车。它的页面像这样：

![image-20230504205632731](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20230504205632731.png)

配置完以后，访问的时候只需要使用二级域名访问即可，十分方便，维护起来也十分傻瓜。



## 前置准备

* VPS任意，我的是在国外自购的一台服务器，为什么自购国外，大家懂得都懂，现在是科学时代。
* 自建家用机服务器，我的服务器主要插上8T*2机械硬盘组磁盘阵列，搞成NAS存储服务器做个私有云。另外结合esxi或者是docker能跑很多好玩的东西，这里就不一一列举了，感兴趣的小伙伴可以搜索一下自建NAS服务器 ALL IN ONE。
* tk域名是白嫖的，在DNS服务商那里却不被支持（这就是白嫖的代价吧）。自己又穷，买不起域名哈哈哈，就搞了个垃圾域名做中转，4块钱人民币一年哈哈哈。



## 网络拓扑图

下面这个是结合自己家庭网络拓扑图和已有的一些服务的网络拓扑图，用这个实现二级域名访问+SSL。

![image-20230504212114306](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20230504212114306.png)

从最右边开始一层一层解释所做的事情：

1. 首先联系联通宽带，给到公网IP，将自己内网服务，在软路由内部通过端口映射的方式开放到外网。如果没有公网IP，也可以用frp等工具实现内网穿透。

2. 接下来要解决公网IP变动的问题（联通给的公网IP是动态的，每隔一段时间就会变）。DNS服务商我选择的是Cloudflare，实现DDNS这块是参考开源项目，改写了一个脚本，其主要功能是：以轮训的方式，动态监测公网IP变更，将A记录通过API的方式更新到Cloudflare以实现DNS解析，具体脚本参考[cloudflare-api-dns](https://github.com/hoey94/cloudflare-api-ddns)，当然网上也有很多类似以封装好的工具实现DDNS，比如[ddns-go](https://github.com/jeessy2/ddns-go)

3. 在自己的VPS上搭建好[Nginx Project Manager](https://github.com/NginxProxyManager/nginx-proxy-manager)（后面我们简称NPM），用来整合自己所有的服务，并添加SSL认证。

4. 在Cloudflare创建记录将tk域名映射到VPS上，反向代理接受到请求，转发到4块钱买的域名(hoey.asia)上，哈哈哈。



## 在CentOS 7上 安装 NPM

1. 确保安装了docker 和docker-compose

```shell
# docker
yum remove -y docker   docker-client   docker-client-latest   docker-common   docker-latest   docker-latest-logrotate   docker-logrotate   docker-selinux   docker-engine-selinux   docker-engine
yum install -y yum-utils   device-mapper-persistent-data   lvm2
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
sudo yum makecache fast
yum install -y docker-ce
systemctl start docker.service
systemctl enable docker.service
docker -v

# docker-compose
curl -L https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version


# 开启ipv6防止日志文件过大 (可选)
cat > /etc/docker/daemon.json <<EOF
{
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "20m",
        "max-file": "3"
    },
    "ipv6": true,
    "fixed-cidr-v6": "fd00:dead:beef:c0::/80",
    "experimental":true,
    "ip6tables":true
}
EOF

systemctl restart docker
```

2. 使用docker-compose 安装npm

```shell
mkdir -p /data/docker_data/npm
cd /data/docker_data/npm
vim docker-compose.yml
# 将内容粘贴进去 start
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'  # 冒号左边可以改成自己服务器未被占用的端口
      - '81:81'  # 冒号左边可以改成自己服务器未被占用的端口
      - '443:443' # 冒号左边可以改成自己服务器未被占用的端口
    volumes:
      - ./data:/data # 冒号左边可以改路径，现在是表示把数据存放在在当前文件夹下的 data 文件夹中
      - ./letsencrypt:/etc/letsencrypt  # 冒号左边可以改路径，现在是表示把数据存放在在当前文件夹下的 letsencrypt 文件夹中
# 将内容粘贴进去 end 
docker-compose up -d
```

3. 更新NPM

```shell
cd /root/data/docker_data/npm

docker-compose down 

cp -r /data/docker_data/npm /data/docker_data/npm.archive  # 万事先备份，以防万一

docker-compose pull

docker-compose up -d    # 请不要使用 docker-compose stop 来停止容器，因为这么做需要额外的时间等待容器停止；docker-compose up -d 直接升级容器时会自动停止并立刻重建新的容器，完全没有必要浪费那些时间。

docker image prune  # prune 命令用来删除不再使用的 docker 对象。删除所有未被 tag 标记和未被容器使用的镜像
```

4. 卸载NPM

```shell
cd /root/data/docker_data/npm

docker-compose down 

rm -rf /root/data/docker_data/npm  # 完全删除映射到本地的数据
```



## 结合Cloudflare 配置NPM



NPM默认账号密码: admin@example.com/changeme，登录后修改

登录Cloudflare，到自己的域名中添加A记录，指向VPS服务器（我的VPS是110.123.11.1，域名是hoey.tk）

![image-20230504222932398](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20230504222932398.png)

在NPM中添加对应的反向代理配置，并打开SSL，（下图是以nas这条记录为例，描述NPM的配置）

![image-20230504214014283](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20230504214014283.png)

之后开启SSL认证

![image-20230504214052552](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20230504214052552.png)

点击保存即可。



## 总结

配置完成以后，就可以使用nas.hoey.tk访问nas服务了，当用户访问nas.hoey.tk时，在网络中它的链路应该如下图所示：

![image-20230504214857962](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20230504214857962.png)

以上
