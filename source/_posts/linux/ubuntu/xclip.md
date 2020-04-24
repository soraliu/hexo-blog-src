---
title: Ubuntu Server 18.04 xclip 使用指南(osx)
date: 2020-04-24 09:48:49
tags:
- ubuntu
- vim
- x11
- xclip
---

## 需求 (Future)

通过 `ssh` 连远程 `ubuntu server(18.04)` 时经常会需要通过 `vim` 编辑文件 `copy` 一些代码，或者通过 `tmux` 复制 `shell` 命令，此时如果需要 `paste` 到本地每次都需要使用鼠标选中，极其麻烦，对于键盘党来说太不友好，偶然听说 `xclip` 可以解决这个问题，于是开始了折腾。中间过程中意外解决了以前遇到的一些杂症，甚是神奇。

## 介绍 (Introduce)

### `X`

- 图形界面并不是 `Linux` 的一部分，和 `Windows95` 及以后的版本就不一样了，他们的图形界面是操作系统的一部分，图形界面在系统内核中就实现了
- `X` 是协议，一个基于X的应用程序需要运行并显示内容时会连接到 `X` 服务器，开始用X协议和服务器通信
- `X11` 是指 X Protocol version 11

## 安装 (Installation)

### Ubuntu 安装 `xclip`

```bash
apt install -y xclip
```

### OSX 安装 `XQuartz`

> The XQuartz project is an open-source effort to develop a version of the [X.Org X Window System](https://www.x.org/) that runs on OS X.

官方网站  [https://www.xquartz.org/](https://www.xquartz.org/)

- 装完之后需要重新登陆系统
- 配置 `Application` ，将 `xterm` 替换成 `iTerm` 的运行路径 `/Applications/iTerm.app/Contents/MacOS/iTerm2` 
- 检查是否配置成功，iTerm 内执行 `echo $DISPLAY`

## 配置 (Configuration)

### 客户端 `ssh` 配置

检查是否已经启用 `X11`

```bash
cat /etc/ssh/ssh_config
```

确认输出包含

```
Host *
  ForwardX11 yes
```

`ssh` 连接时添加 `-X` 参数

```bash
ssh -X root@host
```

### 服务端 `ssh` 配置

```bash
cat /etc/ssh/sshd_config
```

确认输出包含

```
X11Forwarding yes
```

### 服务端 `~/.tmux.conf` 配置

```
# copy to Mac OSX clipboard
if -b 'command -v reattach-to-user-namespace > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | reattach-to-user-namespace pbcopy"'
# copy to X11 clipboard
if -b 'command -v xsel > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xsel -i -b"'
if -b '! command -v xsel > /dev/null 2>&1 && command -v xclip > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xclip -i -selection clipboard >/dev/null 2>&1"'
# copy to Windows clipboard
if -b 'command -v clip.exe > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | clip.exe"'
if -b '[ -c /dev/clipboard ]' 'bind y run -b "tmux save-buffer - > /dev/clipboard"'
```

### 服务端 `~/.vimrc` 配置

```vim
" y
set clipboard=unnamedplus
" copy the filepath of current buff to clipboard
nmap <Leader>c :call system("xclip -i -selection c", expand("%:p"))<CR>

" osx
if !executable('xclip')
  set clipboard=unnamed
  nmap <Leader>c :let @+=expand('%:p')<CR>
endif
```

## Trouble Shooting

### vim 配置好了之后为什么不生效?

- 确认 vim `+clipboard` 已经开启，`vim --version | grep clipboard`，推荐使用  `vim-gtk` 代替系统默认 `vim`
- `mosh` 不支持 `X` 协议

###  意外解决的问题

- **vim 光标** 之前一直用的系统默认 `vim` 发现 `normal` 和 `insert` 相互切换时光标没办法改变(box <-> vertical var)，换成 `gvim` 这个问题就解了
- **zsh 光标** 没启用 `X` 之前一直也无法切换光标形状，开启过后问题已解
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE0Mzc2NTM3MjUsNjI4MTMwNTI1LDE5Mz
kwMzI0NzEsNzU4MDY0MzYwLDE3NDIzNTU5MThdfQ==
-->