---
title: Git Shallow Clone
date: 2019-12-03 17:17:39
tags:
- git
---

## How to clone a commit from a heavy repo ?

```bash
git clone --depth 1 https://github.com/xxx/yyy.git
```

But there is no more messages about commit history. How to resolve it?

```bash
git fetch --help

--unshallow
    Convert a shallow repository to a complete one, removing all the limitations imposed by shallow repositories.
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbNzk4MTcyNTg4XX0=
-->