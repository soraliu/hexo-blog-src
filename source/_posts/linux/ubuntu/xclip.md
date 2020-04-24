```
title: OSX ssh Ubuntu Server 18.04 xclip 使用指南
date: 2020-04-24 09:48:49
tags:
- ubuntu
- vim
- x11
- xclip
```

## 需求 (Future)

通过 `ssh` 连远程 `ubuntu server(18.04)` 时经常会需要通过 `vim` 编辑文件 `copy` 一些代码，或者通过 `tmux` 复制 `shell` 命令，此时如果需要 `paste` 到本地每次都需要使用鼠标选中，极其麻烦，对于键盘党来说太不友好，偶然听说 `xclip` 可以解决这个问题，于是开始了折腾。中间过程中意外解决了以前遇到的一些杂症，甚是神奇。

## 安装 (Installation)

### OSX 安装 `XQuartz`

> The XQuartz project is an open-source effort to develop a version of the [X.Org X Window System](https://www.x.org/) that runs on OS X.

官方网站  [https://www.xquartz.org/](https://www.xquartz.org/)

装完之后需要重新登陆一下简单配置一下 `Application` ，将 `xterm` 替换成 `iTerm` 的运行路径 `/Applications/iTerm.app/Contents/MacOS/iTerm2` 即可

## 配置 (Configuration)

## Trouble Shooting
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTMzOTkxMzk2OCw3NTgwNjQzNjAsMTc0Mj
M1NTkxOF19
-->