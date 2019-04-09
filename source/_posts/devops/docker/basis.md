---
title: docker 基础
date: 2018-05-31 14:30:54
tags:
- docker
---

> 所有命令均在 centOS 7 上执行

## 概念
- 镜像(`Image`)
  - 相当于是一个 root 文件系统
  - 提供容器运行时所需的程序、库、资源、配置等文件
  - 还包含了一些为运行时准备的一些配置参数（如匿名卷、环境变量、用户等）
  - 镜像不包含任何动态数据，其内容在构建之后也不会被改变
  - 镜像是分层存储的，由多层文件系统联合组成
  - 镜像构建时，会一层层构建，前一层是后一层的基础。
  - 每一层构建完就不会再发生改变，后一层上的任何改变只发生在自己这一层。
- 容器(`Container`)
  - 镜像和容器的关系，就像是面向对象程序设计中的 `类` 和 `实例` 一样
  - 容器的实质是进程
  - 容器进程运行于属于自己的独立的命名空间
  - 容器也是使用的是分层存储(`容器存储层`)
  - 容器消亡时，容器存储层也随之消亡。因此，任何保存于容器存储层的信息都会随容器删除而丢失。
  - 容器不应该向其存储层内写入任何数据，容器存储层要保持无状态化
  - 所有的文件写入操作，都应该使用 `数据卷（Volume）`、或者绑定宿主目录
  - 数据卷的生存周期独立于容器，容器消亡，数据卷不会消亡
- 仓库(Registry)
  - registry/repository:tag
  - 默认registry地址 [docker hub](https://hub.docker.com/explore/)
  - 默认registry名 `library`
- 构建(build)
  - Docker 在运行时分为 Docker 引擎（也就是服务端守护进程）和客户端工具
  - Docker 的引擎提供了一组 REST API，被称为 Docker Remote API
  - 而如 docker 命令这样的客户端工具，则是通过这组 API 与 Docker 引擎交互
  - 虽然表面上我们好像是在本机执行各种 docker 功能，但实际上，一切都是使用的远程调用形式在服务端（Docker 引擎）完成
  - 也因为这种 C/S 设计，让我们操作远程服务器的 Docker 引擎变得轻而易举
  - `docker build -t nginx:v3 .` 中的这个 `.`，实际上是在指定上下文的目录
  - docker build 命令会将该目录下的内容打包交给 Docker 引擎以帮助构建镜像
  - 一般来说，应该会将 Dockerfile 置于一个空目录下，或者项目根目录下
  - 如果该目录下没有所需文件，那么应该把所需文件复制一份过来
  - 如果目录下有些东西确实不希望构建时传给 Docker 引擎，那么可以用 .gitignore 一样的语法写一个 .dockerignore，该文件是用于剔除不需要作为上下文传递给 Docker 引擎的。

## Commands
### Image

```bash
# pull
docker pull [选项] [Docker Registry 地址[:端口号]/]仓库名[:标签]

docker pull ubuntu:16.04
```

```bash
# image

# 列出镜像
docker image ls
# 列出所有镜像(包括中间层镜像)
docker image ls -a
# 列出指定仓库镜像
docker image ls ubuntu

# 虚悬镜像(dangling image)
docker image ls -f dangling=true
# 删除虚悬镜像(dangling image)
docker image prune

# 删除镜像
docker image rm [选项] <镜像1> [<镜像2> ...]
docker image rm [Image ID]
docker image rm centos
```

```bash
# system
# 查看docker所占空间
docker system df
```

```bash
docker history imageName:imageTag
```

### `commit`

```bash
# docker commit(慎用)(臃肿) 生成的镜像也被称为黑箱镜像
docker commit \
  --author 'liuxin' \
  --message 'commit msg' \
  containerName \
  imageName:imageTag
```

### `exec`

```bash
docker exec -it containerName bash
```

### `build`

```bash
docker build [选项] <上下文路径/URL/->

docker build -t imageName:imageTag .
```

