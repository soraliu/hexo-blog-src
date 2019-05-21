---
title: JS 动态加载字体
date: 2019-05-21 10:09:21
tags:
- js
- font
---

# Axios + FileReader

> FileReader 对象允许Web应用程序异步读取存储在用户计算机上的文件（或原始数据缓冲区）的内容，使用 File 或 Blob 对象指定要读取的文件或数据。

> File 对象是来自用户在一个 <input> 元素上选择文件后返回的 FileList 对象,也可以是来自由拖放操作生成的 DataTransfer 对象，或者来自 HTMLCanvasElement 上的 mozGetAsFile() API。

> Blob 对象表示一个不可变、原始数据的类文件对象。Blob 表示的不一定是JavaScript原生格式的数据。File 接口基于Blob，继承了 blob 的功能并将其扩展使其支持用户系统上的文件


```js
const woffUrl = chrome.extension.getURL('/libs/fonts/element-icons.woff');

axios.get(woffUrl, {
  responseType: 'blob',
}).then(data => {
  const reader = new FileReader();
  reader.readAsDataURL(data.data);
  reader.onloadend = _ => {
    const woffData = reader.result;

    const newStyle = document.createElement('style');
    newStyle.appendChild(document.createTextNode(`
      @font-face {
          font-family: element-icons;
          src: url(${woffData}) format("woff");
      }\
    `));
    document.head.appendChild(newStyle);
  };
});
```


