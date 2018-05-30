---
title: shell 基础
date: 2018-05-31 00:48:30
tags:
- shell
---

## 变量
- 语法
  - 每句末尾的 `;` 是可选的
  - 赋值
    - 赋值语句 `=` 两边不能有空格
  - 取值
    - `''` 内不会取到变量具体内容
    - `""` 内的变量会被替换成值
  - 判断
    - 判断语句 `[` `]` 两边都需要有空格
    - `-d` 两边都需要空格
    - 多重判断 `[[]]` 间使用 `||` 或者 `&&` 连接，`||` 和 `&&` 两边空格是可选的
  - 循环 `for var in 1 2 3; do` `done`
    - 循环列表中使用空格 ` ` 区分项
    - `do` 为开始 `done` 为结束
    - 使用变量 `$var`
- 变量
  - 使用变量时添加 `$` 前缀
- 函数
  - 函数声明内可以引用函数外部变量
  - 函数内部可以使用作用域链上的变量，但取不到未执行的变量
- 获取用户输入 `read`
  - `-p` 允许输入提示

```bash
#!/bin/bash
for var in "a a" b c; do
  echo $var; # a a, b, c
done


ROOT=$PWD;
echo '$PWD'; # $PWD
echo "$PWD"; # /path/to


createDir() {
  echo $before; # before ...
  echo $after;  # empty line

  for arg in "$@"
  do
    DIR=$ROOT/$arg

    if [ -d $DIR ]; then
      echo "$DIR is already a directory";
    else
      read -p "create $DIR ? (Y/n)" isYes;

      if [[ "$isYes" = "Y" ]] || [[ ! $isYes ]]; then
        mkdir $DIR;
      else
        echo "cancel create $DIR";
      fi
    fi
  done
}

before="before...";

createDir test

after="after...";

```

