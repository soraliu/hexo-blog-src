---
title: Docker FAQ
date: 2018-06-02 01:03:49
tags:
- docker
- faq
---

## Mac 端口映射无效

端口映射语法

```bash
-p [host IP:]<host port>:<container port>
```

```bash
# before
-p 80:80

# now
-p 127.0.0.1:80:80
```

## 重设端口映射

```bash
docker stop nginx
docker commit nginx nginx:v1.0.1
docker run -p 80:80 nginx:v1.0.1
```

## Refs
- [Port forwarding doesn't work at all](https://github.com/docker/for-mac/issues/1675)
- [Assign a port mapping to an existing Docker container](https://stackoverflow.com/questions/19335444/how-do-i-assign-a-port-mapping-to-an-existing-docker-container)


