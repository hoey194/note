---
title: Mac自动SSH+MFA
date: 2022-12-08 19:39:34
tags:
---



因工作需要，使用Iterm2自动跳转远程终端，提高工作效率



# 自动获取MFA Token

安装oath-toolkit

```shell
brew search oath-toolkit
brew install oath-toolkit
```

使用下面命令获取token， 注：${SECKEY} 是一个变量，按照自己的填写

```bash
alias smCode="echo `oathtool --totp -b ${SECKEY} `| pbcopy"
```



# 自定义SHELL+MFA TOKEN脚本

将脚本保存juneyao_auto_ssh_prd.sh

```shell
#!/bin/bash

opts=$@
getParam(){
  arg=$1
  echo $opts | xargs -n1 | cut -b 2- | awk -F'=' '{if($1=="'"$arg"'") print $2}'
}

USER=zhaoyihao
echo "[INFO] USER: "${USER}

HOST=`getParam HOST`
echo "[INFO] HOST: "${HOST}

PASSWORD=`getParam PASSWORD`
echo "[INFO] PASSWORD: *****"

# stg:20 prd:2222
PORT=`getParam PORT`
echo "[INFO] PORT: "${PORT}

PRD_TOKEN="`oathtool --totp -b 4YIKKGPXJD3G32YP`"

sw_login(){
        expect -c "
        # 每个判断等待1秒
        set timeout 1
        spawn ssh $USER@$HOST -p $PORT
        # 判断是否需要保存秘钥
        expect {
                \"yes/no\"   { send yes\n }
        }
        # 判断发送密码
        expect {        
        				\"*assword\" { send $PASSWORD\n }
        }
        # 判断发送验证码
        expect {        
        				\"*OTP Code*\" { send $PRD_TOKEN\n }
        }
        # 停留在当前登录界面
        interact
        "
}
sw_login
```



脚本的使用命令：

```shell
sh juneyao_auto_ssh_prd.sh -HOST=jmp.juneyaoair.com -PORT=2222 -PASSWORD=123123
```



# 与ITerm2集成



在ITerm2终端中进行配置

Preference... -> Profiles -> +![image.png](http://tva1.sinaimg.cn/large/0066vfZIgy1h8woxb34vqj31y01dwe81.jpg)



将脚本运行命令填入到Send text at start:文本框中保存即可。
