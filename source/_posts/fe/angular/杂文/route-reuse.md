---
title: Angular Route Reuse Strategy
date: 2018-09-06 13:59:48
tags:
- angular
- route
---


## 场景
路由跳转的过程相当于是对组件的实例化，销毁过程。
这种机制能够应付绝大部分业务场景，但是在大部分管理系统当中，从 `列表 -> 编辑 -> 保存 -> 返回列表` 该场景需要保存类似搜索，分页等状态数据，此时则需要使用 Angular 的 `RouteReuseStrategy` 贯穿路由状态并决定构建组件的方式。

## RouteReuseStrategy

- `shouldDetach` Determines if this route (and its subtree) should be detached to be reused later.
- `store` Stores the detached route.
- `shouldAttach` Determines if this route (and its subtree) should be reattached.
- `retrieve` Retrieves the previously stored route.
- `shouldReuseRoute` Determines if a route should be reused.

执行顺序如下：

## SimpleReuseStrategy

网上很多例子在这里都是用的 `route.routeConfig.path` 作为 `key`。
如果不涉及到lazy load是不会有问题的，但是如果存在 `loadChildren`，那么`route.routeConfig.path`就有可能会重复。
于是我将 `key` 改为了 `route['_routerState'].url` 取的绝对路径。

```ts
import {
  RouteReuseStrategy,
  DefaultUrlSerializer,
  ActivatedRouteSnapshot,
  DetachedRouteHandle
} from '@angular/router';

export class SimpleReuseStrategy implements RouteReuseStrategy {

  _cacheRouters: { [key: string]: any } = {};

  shouldDetach(route: ActivatedRouteSnapshot): boolean {
    return !route.data.reuse;
  }

  store(route: ActivatedRouteSnapshot, handle: DetachedRouteHandle): void {
    this._cacheRouters[route['_routerState'].url] = {
      snapshot: route,
      handle: handle
    };
  }

  shouldAttach(route: ActivatedRouteSnapshot): boolean {
    return !!this._cacheRouters[route['_routerState'].url];
  }

  retrieve(route: ActivatedRouteSnapshot): DetachedRouteHandle {
    if (!route.routeConfig || route.routeConfig.loadChildren || !this._cacheRouters[route['_routerState'].url]) {
      return null;
    }

    return this._cacheRouters[route['_routerState'].url].handle;
  }

  shouldReuseRoute(future: ActivatedRouteSnapshot, curr: ActivatedRouteSnapshot): boolean {
    // 同一路由时复用路由
    return future['_routerState'].url === curr['_routerState'].url;
  }
}
```

## 注册策略到 `forRoot` 模块。

> lazy laod 的 `forChild` 模块是无法注册的

```ts
@NgModule({
  imports: [
    RouterModule.forRoot(routes),
  ],
  providers: [{
    provide: RouteReuseStrategy,
    useClass: SimpleReuseStrategy,
  }],
  exports: [RouterModule]
})
```

## 具体模块使用

```ts
const routes: Routes = [{
  path: '',
  children: [{
    path: '',
    redirectTo: 'list',
  },  {
    path: 'list',
    component: ListComponent,
    data: {
      reuse: true,
    }
  }, {
    path: 'detail/:id',
    component: DetailComponent,
  }],
}];
```

## Refs
- [angular.cn](https://angular.cn/api/router/RouteReuseStrategy)
- [Angular路由复用策略](https://segmentfault.com/a/1190000011430157#articleHeader1)
- [Angular 5.0 学习8：Angular路由复用策略 (切换页面内容不丢失，保持原来状态)](https://segmentfault.com/a/1190000014944087)

