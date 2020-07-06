---
title: github pages tips
date: 2018-05-28 02:08:11
tags:
- github
- pageg
---

## 自定义域名
- settings -> github pages
![github pages](/assets/images/github/pages.png)

- 设置一条CNAME的域名解析记录值为 `xxx.github.io`
![dns](/assets/images/github/dns.png)

- 在项目根路径中添加文件 `CNAME`, 添加一行记录，不然每次git提交都会重置GitHub pages域名配置

```
blog.soraliu.devlovesora.pro
```

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE4NjQ1NzM5MTBdfQ==
-->