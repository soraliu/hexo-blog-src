---
title: Angualr 开源组件设计
date: 2018-09-10 18:06:25
tags:
- angular
- os
---

## 序
公司的技术展选择的是 `Angular` ，设计风格也是Google的 `Mateiral Design`。Goolge官方团队有提供一套Material Angular版本的组件库 [material.angular.io](https://material.angular.io)。但是国人的操作习惯与国外还是有一些区别，针对这部分业务，公司打算基于官方组件，封装一些自定义的组件，并且开源出来。这一过程当中，主要对以下几个方面做了一些考虑。希望能对大家的开源项目有所帮助。不足之处还望多多包含( ´ ▽ ` )。

> [Github](https://github.com/petkit-io/ngx-os) 欢迎大家Star

- Debug
- Demo 及 Demo源代码
- Build
- Github开源
- npm发布

## 目录结构
![directory](/assets/images/angular/os/ngx-os-directory.png)

## Debug
Debug阶段主要考虑到的是路径引入问题，为了让 `Demo源代码` 能够和生产环境下的使用保持一致，在 `PROJECT_ROOT/tsconfig.json` (PROJECT_ROOT指项目根目录)中做了一些配置

```json
{
  ...
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@petkit/*": [
        "./src/lib/*"
      ],
      "demo/*": [
        "./src/demo/*"
      ],
      "util/*": [
        "./src/util/*"
      ]
    }
  }
  ...
}
```

将所有 `@petkit/` 开头的路径引入转换至 `src/lib/` 下 

> [schema](http://json.schemastore.org/tsconfig)

```ts
import { NgxHighlightModule } from '@petkit/ngx-highlight';
```

将被转换为

```ts
import { NgxHighlightModule } from 'PROJECT_ROOT/src/lib/ngx-highlight';
```

## Demo 及 Demo源代码
这里参考了Angualar Material官方团队的设计（此处Demo和Example概念与官方有出入，官方的示例代码是放在example目录下的，个人觉得都可以，只是项目已经配好了，就不想再去调整得与官方保持一致了）。

> [material 2](https://github.com/angular/material2/tree/master/src/material-examples)

将所有demo目录下的文件作为静态资源，通过http请求源代码，使用 `ngx-highlight` 高亮语法。 `angular.json` 配置如下

```json
{
  "projects": {
    "example": {
      "root": ".",
      "sourceRoot": "src/example",
      "architect": {
        "build": {
          "options": {
            "assets": [
              {
                "glob": "**/*",
                "input": "src/demo",
                "output": "assets/demo"
              },
              "src/example/assets"
            ]
          }
        }
      }
    }
  }
}
```

> 注：`sourceRoot` 是 `ng g *` 的相对路径

`demo` 与 `example` 同级，直接引入会报错

```
{
  ...
  "assets": [
    // Error: The src/demo asset path must start with the project source root.
    "src/demo",
    "src/example/assets"
  ]
  ...
}
```

demo会被当作静态资源输出至 `dist/example/assets/demo`，此时使用http请求对应路径文件即可。

## Build
这部分已经有现成的库 `ng packagr` 可以帮助我们直接打包了

> [ng-packagr](https://github.com/ng-packagr/ng-packagr)

```bash
ng-packagr -p ./src/**/package.json
```

## Github 开源
针对 `lib` 下的源代码，采用 `git submodule` 的方式可以帮助我们更好地维护开源组件。

> 关于 `git submodule` segmentfault 上有篇文章写得蛮不错的 [git submodule](https://segmentfault.com/a/1190000003076028)

```bash
git submodule add git@github.com:petkit-io/ngx-highlight.git src/lib/ngx-highlight
```

## npm发布
`ng-packagr` 打包出来的代码便可以直接发布。

```bash
npm publish path --access public;
```

npm 上的 organization 需要加上 `--access public` 才能发布。每次发布完成后自动生成 `CHANGELOG`，打上新的版本号。

> [conventional-changelog](https://github.com/conventional-changelog/conventional-changelog) 可以帮助我们自动生成Change Log
> [commitlint](https://github.com/marionebl/commitlint)可以帮助我们规范commit message


## 自动化

`build` `github` `npm` 三个阶段可以通过脚本自动执行。`PROJECT_ROOT/bin/pub.sh`：

```bash
#!/usr/bin/env bash
libRoot=src/lib;
distRoot=dist;

buildLib() {
  packagePath=$1;

  npx ng-packagr -p $packagePath;
}

publishLib() {
  libName=$1;
  libPath=$libRoot/$libName;

  buildLib $libPath/package.json;
  npm publish $distRoot/$libName --access public;

  cd $libPath;
  git add .;
  git commit -m "chore(version): publish npmjs" 1>/dev/null 2>&1;
  npm version patch;
  git push;
  git push --tags;
}

publishLib $1
```

`maidfile.md`：

```md
## pub

发布类库
命令格式 `npx maid pub [lib-name]`

e.g.
- `npx maid pub ts-lib`
- `npx maid pub ngx-material`

```bash
libName=$1

command="./bin/pub.sh $libName"

echo $command

$command
```

使用：

```
npx maid pub ngx-highlight
```

## End
整体结构还有一些不完善的地方，希望大家多多提些建议，我们也会逐步改善。

> [Github](https://github.com/petkit-io/ngx-os) Star Star Star 重要的事情说三遍o(≧v≦)o

