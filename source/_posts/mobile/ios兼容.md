---
title: IOS移动端兼容性
date: 2018-07-03 20:40:43
tags:
- mobile
- compat
---

## Safari如何阻止“橡皮筋效果”？

```js
document.body.addEventListener('touchmove', function (e) {
  //阻止默认的处理方式(阻止下拉滑动的效果)
  e.preventDefault();
}, {
  //passive 参数不能省略，用来兼容ios和android
  passive: false
});
```

**Refs**
- [阻止微信浏览器下拉滑动效果（ios11.3 橡皮筋效果）](https://link.zhihu.com/?target=https%3A//segmentfault.com/a/1190000014134234)

