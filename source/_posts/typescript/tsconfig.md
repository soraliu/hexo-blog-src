---
title: tsconfig 浅析
date: 2018-08-09 11:24:58
tags:
- ts
---

### 相对 vs. 非相对模块导入

根据模块引用是相对的还是非相对的，模块导入会以不同的方式解析。

相对导入是以/，./或../开头的。 下面是一些例子：

```ts
import Entry from "./components/Entry";
import { DefaultHeaders } from "../constants/http";
import "/mod";
```

所有其它形式的导入被当作非相对的。 下面是一些例子：

```ts
import * as $ from "jQuery";
import { Component } from "@angular/core";
```

相对导入在解析时是相对于导入它的文件，并且不能解析为一个外部模块声明。 你应该为你自己写的模块使用相对导入，这样能确保它们在运行时的相对位置。

非相对模块的导入可以相对于 `baseUrl` 或通过下文会讲到的路径映射来进行解析。 它们还可以被解析成 [外部模块声明](https://www.tslang.cn/docs/handbook/modules.html#ambient-modules)。 使用非相对路径来导入你的外部依赖

### 路径映射

有时模块不是直接放在`baseUrl`下面。 比如，充分 `"jquery"`模块地导入，在运行时可能被解释为 `"node_modules/jquery/dist/jquery.slim.min.js"`。加载器使用映射配置来将模块名映射到运行时的文件。

TypeScript编译器通过使用tsconfig.json文件里的"paths"来支持这样的声明映射。 下面是一个如何指定 jquery的"paths"的例子。

```ts
{
  "compilerOptions": {
    "baseUrl": ".", // This must be specified if "paths" is.
    "paths": {
      "jquery": ["node_modules/jquery/dist/jquery"] // 此处映射是相对于"baseUrl"
    }
  }
}
```

请注意`"paths"`是相对于`"baseUrl"`进行解析。 如果 `"baseUrl"`被设置成了除`"."`外的其它值，比如`tsconfig.json`所在的目录，那么映射必须要做相应的改变。
如果你在上例中设置了 `"baseUrl": "./src"`，那么`jquery`应该映射到`"../node_modules/jquery/dist/jquery"`。

### Refs
- [tslang.cn](https://www.tslang.cn/docs/handbook/module-resolution.html)
- [zhihu](https://zhuanlan.zhihu.com/p/21629069)

