---
title: Hexo 插件 Gitment安装
date: 2019-04-10 22:37:12
tags:
- hexo
---

## Get Started

### 1. Install

```html
<link rel="stylesheet" href="https://imsun.github.io/gitment/style/default.css">
```

```html
<script src="https://imsun.github.io/gitment/dist/gitment.browser.js"></script>
```

or via npm:

```sh
$ npm i --save gitment
```

```javascript
import 'gitment/style/default.css'
import Gitment from 'gitment'
```

### 2. Register An OAuth Application

> [Click here](https://github.com/settings/applications/new)

注意 http 和 https

![oauth](/assets/images/blog/hexo/OAuth.png)

### 3. Render Gitment

```javascript
const gitment = new Gitment({
  id: 'Your page ID', // optional
  owner: 'Your GitHub ID',
  repo: 'The repo to store comments',
  oauth: {
    client_id: 'Your client ID',
    client_secret: 'Your client secret',
  },
  // ...
  // For more available options, check out the documentation below
})

gitment.render('comments')
// or
// gitment.render(document.getElementById('comments'))
// or
// document.body.appendChild(gitment.render())
```

## FAQ

### Error: Comments Not Initialized

出现这个错误一般有两个原因

1. 没有登录
2. OAuth配置有问题，检查一下回调是否正确

### 登录时浏览器弹出[Object ProgressEvent]

这个问题稍微复杂一点，简单一点的方案是直接替换 `gitment.browser.js`的路径

```html
<link rel="stylesheet" href="//lovesoraliu.github.io/gitment/style/default.css">
<script src="//lovesoraliu.github.io/gitment/dist/gitment.browser.js"></script>
```

如果想要自己折腾的话略微有些麻烦，大致步骤如下

#### 1. clone server

在自己服务器上clone [gh-oauth-server](https://github.com/imsun/gh-oauth-server), 执行

```shell
# 端口号默认是3000
npm start
```

启动 `gitment server`

#### 2. clone gitment

`fork` [gitment](https://github.com/imsun/gitment), `clone` fork的代码到本地，切到 `gh-pages` 分支

#### 3. 修改url

将 `https://gh-oauth.imsun.net` 改为自己服务器的 `http(s)` + `domain or ip` + `port`。

```js
_utils.http.post('https://gh-oauth.imsun.net', {
  code: code,
  client_id: client_id,
  client_secret: client_secret
}, '').then(function (data) {
  _this.accessToken = data.access_token;
  _this.update();
}).catch(function (e) {
  _this.state.user.isLoggingIn = false;
  alert(e);
});
```

```js
_utils.http.post('https://gitment.soraliu.devlovesora.pro', {
  code: code,
  client_id: client_id,
  client_secret: client_secret
}, '').then(function (data) {
  _this.accessToken = data.access_token;
  _this.update();
}).catch(function (e) {
  _this.state.user.isLoggingIn = false;
  alert(e);
});
```

#### 4. push代码 & 修改文件路径

将刚才的改动 `push` 至 `github`，再修改 `gitment.browser.js` 的url 即可

```html
<link rel="stylesheet" href="//[username].github.io/gitment/style/default.css">
<script src="//[username].github.io/gitment/dist/gitment.browser.js"></script>
```

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTE5MzI0OTgzMV19
-->