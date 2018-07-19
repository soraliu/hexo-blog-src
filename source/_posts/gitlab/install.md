---
title: Gitlab Docker安装
date: 2018-07-19 15:01:57
tags:
- gitlab
---

## 安装 `GitLab`

```bash
docker pull gitlab
```

## 运行容器

```bash
docker run --detach \
  --hostname gitlab.example.com \
  --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.example.com';" \
  --publish 443:443 --publish 8000:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
```

## 配置 `Nginx` 反向代理

```nginx
# /etc/nginx/conf.d/gitlab.conf

server {
  listen 80;
  server_name gitlab.example.com;

  access_log  /var/log/nginx/gitlab.access.log  main;

  location / {
    proxy_pass http://localhost:8000;
    index  index.html index.htm;
  }
}
```

## 设置密码

第一次访问 `gitlab.example.com` 会提示输入密码，用户名默认是 `root`。

## 坑

### `docker0: iptables: No chain/target/match by that name`

重启docker即可

```bash
systemctl restart docker.service
```

## Refs

- [官方文档](https://docs.gitlab.com/omnibus/docker/)


