---
title: git常用命令
date: 2018-05-25 22:08:09
tags: [git, cli]
---
## git检出远程分支

`git checkout -b localBranch remote/branchName`

## 回退到制定版本

```bash
git log #查看版本提交日志
git reset --hard 61e0e8b94667afe99c8dcd4f954ad69d0d6f49e8 
```

## 列出远程tag列表

```bash
git ls-remote --tag
```

## 检出所有远程分支

```bash
for branch in $(git branch --all | grep '^\s*remotes' | egrep --invert-match '(:?HEAD|master)$'); do
    git branch --track "${branch##*/}" "$branch" 2>/dev/null
done
```

## 删除所有远程tag

```bash
# xargs -p 可打印出将执行的命令
git tag | xargs -n1 git push origin --delete
```

