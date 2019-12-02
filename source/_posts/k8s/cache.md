---
title: The Cache of React Pipeline
date: 2019-12-02 11:41:02
tag:
- cache
- pipeline
---

## Build Cache
我们在做pipeline相关优化的时候，一个很重要的指标就是构建时间，最基本的优化就是构建缓存。

基本思路就是每次 `build` 之前 `restore` 上次的缓存，构建完成后 `rebuild` 当前缓存。

`cache` 我们试过几种种:
- node 上的 `volume`： EBS(RWO), EFS(RWX)等
- s3

EBS只支持 `ReadWriteOnly`, EFS支持 `ReadWriteMany`，

### The cache of CRA

> [webpack build cache](https://webpack.js.org/configuration/other-options/#cache)
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTMxMDc3NjM5NF19
-->