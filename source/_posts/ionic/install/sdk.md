---
title: 在fish中使用sdkman
date: 2018-06-05 00:47:52
tags:
- fish
- sdkman
---

## 安装 `sdkman`

```bash
curl -s "https://get.sdkman.io" | bash
```

## 创建文件 `$HOME/.config/fish/conf.d/sdkman.fish`
写入以下代码

```bash
#!/usr/bin/fish

# sdk command
function sdk
        bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk $argv"
end

# add paths
for ITEM in $HOME/.sdkman/candidates/* ;
        set -gx PATH $PATH $ITEM/current/bin
end
```

## Refs
- [sdkman doesn't work with Fish shell](https://github.com/sdkman/sdkman-cli/issues/294)
