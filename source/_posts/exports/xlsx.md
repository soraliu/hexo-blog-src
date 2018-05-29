---
title: XLSX 导出excel文件 (TS)
date: 2018-05-29 11:45:30
tags:
- xlsx
---

## Step 1. 安装依赖 `xlsx`

```shell
yarn add xlsx
```

## Step 2. Import

```ts
import * as XLSX from 'xlsx';
```

## Step 3. Usage

xlsx支持多种格式导出，具体可以参考官方文档[github](https://github.com/SheetJS/js-xlsx)

```ts
class Export {
  private _wb: XLSX.WorkBook = XLSX.utils.book_new();

  appendSheet(aoaData, {
    sheetName = 'sheet',
  } = {}) {
    // 与左上角和右下角确认一个矩形相似
    const merge = {
      // start
      s: {
        // row
        r: 0,
        // column
        c: 0
      },
      // end
      e: {
        r: 0,
        c: 1,
      }
    };
    // 与以下写法结果相同
    // const merge = XLSX.utils.decode_range("A1:A2");

    const ws: XLSX.WorkSheet = XLSX.utils.aoa_to_sheet(aoaData);

    if (!ws['!merges']) {
       ws['!merges'] = [];
    }
    ws['!merges'].push(merge);

    XLSX.utils.book_append_sheet(this._wb, ws, sheetName);
  }

  exportExcelFile(filename = 'export.xlsx') {
    XLSX.writeFile(this._wb, filename);
  }
}
```

```ts
let exports = new Export();

exports.appendSheet([['a', 'b'], ['c'], ['d', 'e', 'f']]);

exports.exportExcelFile();
```

![output](/assets/images/output/export.png)


## Refs
> [js-xlsx](https://github.com/SheetJS/js-xlsx)
> [merge cells from Array of Arrays](https://github.com/SheetJS/js-xlsx/issues/964)

