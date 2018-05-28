---
title: Angular Library 分离实践
date: 2018-05-28 16:22:22
tags:
- angular
- library
---

> 原理就是利用绝对路径加载Library项目，其本身是可以抽离出去单独作为一个项目维护的。
> 在`angular 6`发布之前一直实用的`ng-packagr`手动构建angular library。
> `angular 6`发布后可以通过`ng g library xxx` 自动生成lib项目，但是目前还不够完善，不支持实时编译，还有待完善。
> 本文主要是优化library项目在开发阶段和project项目之间的调试问题。

## 目录结构

```
root
  |-projects
    |-material
    |-common
    |-flux
  |-src
    |-tsconfig.app.json
    |-tsconfig.spec.json
  tsconfig.json
```

## 去除 `tsconfig.app.json` 和 `tsconfig.spec.json` 中的 `baseUrl`

```json
// before
{
  "extends": "../tsconfig.json",
  "compilerOptions": {
    "baseUrl": "./",
    "outDir": "../out-tsc/app",
    "module": "es2015",
    "types": []
  },
  "exclude": [
    "test.ts",
    "**/*.spec.ts",
    "../node_modules/@petkit/**/*"
  ]
}

// now
{
  "extends": "../tsconfig.json",
  "compilerOptions": {
    "outDir": "../out-tsc/app",
    "module": "es2015",
    "types": []
  },
  "exclude": [
    "test.ts",
    "**/*.spec.ts",
    "../node_modules/@petkit/**/*"
  ]
}

```

## 在 `tsconfig.json` 中添加 `baseUrl`, 配置 `paths`

```json
{
  "compilerOptions": {
    "baseUrl": "./",
    "paths": {
      "@libs/*": [
        "projects/*"
      ]
    }
  }
}
```

** 注意 **
1. library项目中需要在根路径加上`index.ts`，以便与实际生产环境下的引用方式保持一致

```ts
// index.ts
export * from './public_api';
```

