---
title: Git Stash 保存和恢复进度
date: 2018-06-14 10:48:09
tags:
- git
---

> `stash` 使用的`stack`数据结构，先进先出

## 保存进度

```bash
# 不包括untracked的文件（比如新增的文件，不会被添加至储藏）
# untrack 的文件在stash后依然可见——即依然在工作空间中，不会被保存到stash镜像中，因此对 untrack 文件的修改不能通过 stash pop 恢复——因为该命令不暂存未track的文件
git stash

# 添加 message
git stash save 'message...'

# 添加(untracked)暂存区的文件（新增的文件会被移动至储藏）
git stash save -u 'message...'

# 添加所有(--all)文件（包括.gitignore中忽略的文件)（比如node_modules，执行该命令后就也会被移除了，可以看作刚clone下来时的状态）
git stash save -a 'message...'
```

## 查看进度列表

```bash
git stash list
# stash@{0}: WIP on master: ef0f1dc message...
```

## 恢复进度

```bash
# 恢复至最新进度并且删除
git stash pop

# 指定进度index
# 这里的 3 指的 git stash list 显示的列表里 stash@{3} 中括号里面的数字
git stash pop 3

# 恢复但不删除
git stash apply
git stash apply 3
```

## 删除进度

```bash
# 删除最新进度
git stash drop

# 指定进度index
git stash drop 3

# 删除所有进度
git stash clear
```

## Refs
- [Git-工具-储藏](https://git-scm.com/book/zh/v1/Git-%E5%B7%A5%E5%85%B7-%E5%82%A8%E8%97%8F%EF%BC%88Stashing%EF%BC%89)
