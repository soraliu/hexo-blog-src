---
title: Ubuntu 内核升级
date: 2019-04-18 20:31:59
tags:
- ubuntu
---

## 查看发布版本号

```bash
cat /etc/issue

lsb_release -a
```

## 查看内核版本号

```bash
# 内核信息
uname -sr

# 所有信息
uname -a
```

## 升级方式一

> 到官网[kernel.ubuntu.com](https://kernel.ubuntu.com/~kernel-ppa/mainline/)下载对应deb文件

![列表](/assets/images/linux/ubuntu-kernel.png)

![文件](/assets/images/linux/ubuntu-kernel-download.png)


下载 `*all.deb` 和所有 `*generic*.deb` 文件后，到对应文件夹下执行


```bash
sudo dpkg -i *.deb
```

> 我是64位操作系统所以选择的 `amd64`，32位的小伙伴选 `i386`即可

## 升级方式二（推荐）

### 查看需要更新的内核命令

```bash
apt-cache search linux
```

### 安装对应版本内核

```bash
sudo apt install linux-headers-5.0.8-050008-generic
```

![install](/assets/images/linux/ubuntu-kernel-install.png)


> 安装完成后默认启动最新内核

```bash
# 查看内核启动顺序
grep menuentry /boot/grub/grub.cfg
```

## 卸载多余内核

```bash
sudo apt-get autoremove
```

