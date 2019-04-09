---
title: angular v5升级至v6
date: 2018-05-28 11:15:31
tags:
- angular
- upgrade
---

## 安装v8版node lts

```bash
# now is 8.11.2
sudo n lts
```

## 升级 `@angular/cli`

```bash
npm uninstall -g @angular/cli
npm cache verify
npm i -g @angular/cli@6.0.0
```

## 修改所有angular依赖至v6

```json
{
  "devDependencies": {
    "@angular-devkit/build-angular": "~0.6.0",
    "@angular/animations": "^6.0.0",
    "@angular/cdk": "^6.0.0",
    "@angular/cli": "^6.0.0",
    "@angular/common": "^6.0.0",
    "@angular/compiler": "^6.0.0",
    "@angular/compiler-cli": "^6.0.0",
    "@angular/core": "^6.0.0",
    "@angular/forms": "^6.0.0",
    "@angular/http": "^6.0.0",
    "@angular/material": "^6.0.0",
    "@angular/platform-browser": "^6.0.0",
    "@angular/platform-browser-dynamic": "^6.0.0",
    "@angular/router": "^6.0.0",
    "rxjs": "^6.0.0",
    "rxjs-compat": "^6.0.0",
    "tsickle": "0.27.5",
    "tslib": "1.9.0",
    "typescript": "2.7.2",
    "zone.js": "~0.8.26"
  }
}
```

## 重装 `node_modules`

```bash
rm -rf node_modules
yarn install
```

## 删除`.angular-cli.json`，添加`.angular.json`

```bash
ng update @angular/cli --migrate-only --from=1.7.4
```

## Finished
大功告成


## 新特性

1. [angular](https://juejin.im/post/5aeebbce6fb9a07aa213406e)


## break change
- [rxjs v6](https://github.com/ReactiveX/rxjs/blob/master/MIGRATION.md)
  - 链式操作改为`pipe`

```ts
// before
source
 .map(x => x + x)
 .mergeMap(n => of(n + 1, n + 2)
   .filter(x => x % 1 == 0)
   .scan((acc, x) => acc + x, 0)
 )
 .catch(err => of('error found'))
 .subscribe(printResult);

// now
source.pipe(
 map(x => x + x),
 mergeMap(n => of(n + 1, n + 2).pipe(
   filter(x => x % 1 == 0),
   scan((acc, x) => acc + x, 0),
 )),
 catchError(err => of('error found')),
).subscribe(printResult); 
```

  - 操作符导入路径

```ts
import { Observable, Subject, asapScheduler, pipe, of, from, interval, merge, fromEvent } from 'rxjs';
import { map, filter, scan } from 'rxjs/operators';
import { webSocket } from 'rxjs/webSocket';
import { ajax } from 'rxjs/ajax';
import { TestScheduler } from 'rxjs/testing';
```

  - 部分操作符重命名

```
do -> tap
catch -> catchError
switch -> switchAll
finally -> finalize
```

  - 部分操作符在v7版将废弃

```
mergeMap()
mergeMapTo()
concatMap()
concatMapTo()
switchMap
switchMapTo()
exhaustMap()
forkJoin()
zip()
combineLatest()
fromEvent()
```

