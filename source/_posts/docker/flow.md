---
title: docker flow
date: 2018-06-05 18:23:26
tags:
- docker
- flow
---

## Flow

- 导入镜像

```bash
docker import centos-ng-0.0.2.tar centos:ng-0.0.2
```

- 运行容器

```bash
docker run -it -d --name centos-ng-v0.0.2 \
  -p 127.0.0.1:7203:7203 -p 127.0.0.1:7204:7204 \
  --volume /Users/liuxin/docker/centos-ng:/opt/petkit \
  centos:ng-0.0.2 bash
```

- 进入容器终端

```bash
docker exec -it centos-ng-v0.0.2 bash
```

- 退出终端

```bash
$ exit
```

- 启动／停止容器

```bash
docker start centos-ng-v0.0.2
docker stop centos-ng-v0.0.2
```

- 查看所有容器

```bash
docker ps -a
```

- 从容器导出镜像

```bash
docker export -o centos-ng-0.0.2.tar a843ae730779
```

