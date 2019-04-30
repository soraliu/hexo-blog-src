---
title: 记一次数组赋值导致的页面卡死
date: 2019-04-29 16:58:03
tags:
- 性能优化
- array
---

## 前言

一个很简单的功能直接导致页面卡死

```js
const arr = [];
arr[4294967294] = 'arr';
arr.map(item => console.log(item));
```

尝试在控制台运行以上代码...

## 解析

> JavaScript 使用一个32位整数，保存数组的元素个数。这意味着，数组成员最多只有 4294967295 个（232 - 1）个，也就是说length属性的最大值就是 4294967295。

```js
var arr = ['a', 'b'];
arr.length // 2

arr[2] = 'c';
arr.length // 3

arr[9] = 'd';
arr.length // 10

arr[1000] = 'e';
arr.length // 1001
```

数组的遍历会从索引 `0` 开始一直到 `length-1`

所以，以下代码往往不可控

```ts
let key: number;

...

const arr = [];
arr[key] = ...
arr.map(item => ...);
```

对数组以一个 `number` 类型的变量作为 `key` 赋值后，再使用 `map, forEach, for...` 等来遍历数组时，由于 `key` 的值不可控，如果是数据库中的 `主键id`，那么在数据量小的时候发现不了什么异常，一旦数据量过大，浏览器直接就会卡死!


