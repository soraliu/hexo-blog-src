---
title: git常用命令
date: 2018-05-25 22:08:09
tags: [git, cli]
---
## git检出远程分支
`git checkout -b localBranch remote/branchName`

## 回退到制定版本
```bash
$ git log #查看版本提交日志
$ git reset --hard 61e0e8b94667afe99c8dcd4f954ad69d0d6f49e8 
```
