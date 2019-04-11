---
title: Angular Router Reuse
date: 2019-04-11 22:56:52
tags:
- angular
- router
---

## 序言

路由在切换时需要销毁当前组件，这在大多数情况下是符合预期的。但是有些时候在一些列表 + 详情的结构下，进入详情后再返回列表需要保留之前的列表状态，此时就需要缓存列表路由。

### 现有方案

```ts
// route-reuse.strategy.ts

import {
  RouteReuseStrategy,
  DefaultUrlSerializer,
  ActivatedRouteSnapshot,
  DetachedRouteHandle
} from '@angular/router';

export class SimpleReuseStrategy implements RouteReuseStrategy {

  _cacheRouters: { [key: string]: any } = {};

  shouldDetach(route: ActivatedRouteSnapshot): boolean {
    return !!route.data.keep;
  }

  store(route: ActivatedRouteSnapshot, handle: DetachedRouteHandle): void {
    this._cacheRouters[this._getCacheKey(route)] = {
      snapshot: route,
      handle: handle
    };
  }

  shouldAttach(route: ActivatedRouteSnapshot): boolean {
    return route.data.keep && !!this._cacheRouters[this._getCacheKey(route)];
  }

  retrieve(route: ActivatedRouteSnapshot): DetachedRouteHandle {
    if (!route.data.keep || !this._cacheRouters[this._getCacheKey(route)]) {
      return null;
    }
    return this._cacheRouters[this._getCacheKey(route)].handle;
  }

  shouldReuseRoute(future: ActivatedRouteSnapshot, curr: ActivatedRouteSnapshot): boolean {
    return this._getCacheKey(future) === this._getCacheKey(curr);
  }

  _getCacheKey(route: ActivatedRouteSnapshot): string {
    return route['_routerState'].url;
  }
}
```

```ts
// app-routing.module.ts
import {
  RouteReuseStrategy,
  RouterModule,
} from '@angular/router';

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

export class AppRoutingModule { }
```

```ts
// 任意一个页面组件
import {
  NavigationEnd,
  Router,
} from '@angular/router';

constructor(
  private router: Router
) {
  this.router.events
    .filter((event) => event instanceof NavigationEnd)
    .subscribe((event: NavigationEnd) => {
      // 这里需要判断一下当前路由，如果不加的话，每次路由结束的时候都会执行这里的方法
      if (event.url.indexOf('currentRoute') > -1) {
        // 进入当前路由需要重新执行的操作
        ...
      }
    });
}
```

## 问题

**同一父路由** 下的子路由之间的跳转会重新初始化 parent component。翻了翻源代码这才找到了答案。

## RouteReuseStrategy 抽象类

> Provides a way to customize when activated routes get reused. [code](https://github.com/angular/angular/blob/master/packages/router/src/route_reuse_strategy.ts)

```ts
export abstract class RouteReuseStrategy {
  /** Determines if this route (and its subtree) should be detached to be reused later */
  abstract shouldDetach(route: ActivatedRouteSnapshot): boolean;

  /**
   * Stores the detached route.
   *
   * Storing a `null` value should erase the previously stored value.
   */
  abstract store(route: ActivatedRouteSnapshot, handle: DetachedRouteHandle|null): void;

  /** Determines if this route (and its subtree) should be reattached */
  abstract shouldAttach(route: ActivatedRouteSnapshot): boolean;

  /** Retrieves the previously stored route */
  abstract retrieve(route: ActivatedRouteSnapshot): DetachedRouteHandle|null;

  /** Determines if a route should be reused */
  abstract shouldReuseRoute(future: ActivatedRouteSnapshot, curr: ActivatedRouteSnapshot): boolean;
}
```

官方默认的 `ReuseStrategy` 如下

```ts
/**
 * Does not detach any subtrees. Reuses routes as long as their route config is the same.
 */
export class DefaultRouteReuseStrategy implements RouteReuseStrategy {
  shouldDetach(route: ActivatedRouteSnapshot): boolean { return false; }
  store(route: ActivatedRouteSnapshot, detachedTree: DetachedRouteHandle): void {}
  shouldAttach(route: ActivatedRouteSnapshot): boolean { return false; }
  retrieve(route: ActivatedRouteSnapshot): DetachedRouteHandle|null { return null; }
  shouldReuseRoute(future: ActivatedRouteSnapshot, curr: ActivatedRouteSnapshot): boolean {
    return future.routeConfig === curr.routeConfig;
  }
}
```

对比发现 `shouldReuseRoute` 中的判断条件不一样。于是将原有代码做了一些调整

```ts
shouldReuseRoute(future: ActivatedRouteSnapshot, curr: ActivatedRouteSnapshot): boolean {
  return future.routeConfig === curr.routeConfig || this._getCacheKey(future) === this._getCacheKey(curr);
}
```

此时同一父路由下的子路由之间的跳转不会再初始化父组件了。

