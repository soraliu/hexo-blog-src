---
title: Centos 7 安装SSL
date: 2018-07-27 10:07:02
tags:
- centos
- ssl
- nginx
---

## 安装epel-release

```bash
yum install -y epel-release

yum search python2-certbot-nginx

# 如果没有对应的package
yum reinstall -y epel-release
yum update -y
```

## 生成ssl

```bash
certbot --nginx -d gitlab.example.com
```

## Issues
1. 找不到 `nginx` 命令
解决方案：将nginx命令所在目录添加至环境变量
```bash
vim /etc/profile
PATH=$PATH:/usr/sbin;
```

2. 浏览器无法访问 `https://xxxx`
解决方案：将443端口添加至防火墙
```bash
vim /etc/firewalld/services/ssh.xml

# add rule
<port protocol="tcp" port="443"/>
```

## Refs
- [certbot](https://certbot.eff.org/lets-encrypt/centosrhel7-nginx)


