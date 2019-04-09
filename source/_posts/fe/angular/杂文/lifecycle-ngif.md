---
title: 记 `*ngIf` 生命周期导致的一个坑
date: 2018-09-19 16:07:03
tags:
- 
---

## 情景

`*ngIf` 中的 `ViewChild` 要在 `ngAfterViewInit` 生命周期钩子中才能拿到。

```ts
{
  condition = true;
  @ViewChild('div') div: ElementRef;

  ngOnInit() {
    console.log(this.div); // undefined
  }

  ngAfterContentInit() {
    console.log(this.div); // undefined
  }

  ngAfterViewInit() {
    console.log(this.div); // ElementRef
  }
}
```

```html
<ng-container *ngIf="condition">
  <div #div></div>
</ng-container>
```





