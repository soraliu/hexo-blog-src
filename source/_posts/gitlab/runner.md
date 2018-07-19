---
title: GitLab CI/CD Runner 入门
date: 2018-07-19 14:05:56
tags:
- gitlab
- ci
---

我自己用的 `Centos 7 x64` ，一下流程都是以 `Centos 7 x64` `roor`权限为基础的

## 安装
> [Linux手动安装](https://docs.gitlab.com/runner/install/linux-manually.html)
> [使用Docker](https://docs.gitlab.com/runner/install/docker.html)

```bash
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash
yum install gitlab-runner
```

## 使用
> [官方Runner命令手册](https://docs.gitlab.com/runner/commands/README.html#gitlab-runner-install)

### 1. 注册runner

```bash
# register
gitlab-runner register \
  --name runner-name \
  --url http://gitlab.example.com \
  --registration-token my-registration-token \
  --executor shell

# 查看runner列表
gitlab-runner list
```

> 这里遇到了个坑，不添加 `--executor` 会报错
> `running register from command line, `--executor X` results in: `ERROR: Invalid executor specified``
> 但是官方文档里却没有说必须要加

### 2. 启动服务

```bash
# 安装服务
gitlab-runner install runner-name --user root

# 启动
gitlab-runner start runner-name

# 查看服务启动状态
gitlab-runner status runner-name
```

### 3. 配置runner tag

先说一下 `Specific Runners` 。

这个tag配置是用来 `标识` 该 `runner` 的。

进入`[Settings -> CI/CD -> Specific Runners]` ，点击编辑按钮(这个按钮我是找了好久才找到)，添加一个tag，在job中可以通过指定tags来定位到对应的 `Runner`


![runners](/assets/images/gitlab/runners.jpg)

![runners tag](/assets/images/gitlab/runners-tag.jpg)

关于 `jobs` 这里有几篇很不错的文章，我就不多赘述了。

> [官方文档](https://docs.gitlab.com/ce/ci/yaml/README.html#stages)
> [gitlab-ci配置详解(二)](https://segmentfault.com/a/1190000011890710)

