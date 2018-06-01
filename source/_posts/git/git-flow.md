---
title: git flow
date: 2018-05-28 11:21:03
tags:
- git
- flow
---

# Generate the Commit Message
## Install `commitizen`
```bash
# install
yarn global add commitizen

# exec in project root
commitizen init cz-conventional-changelog --save --save-exact
```

# Validate the Commit Message
## Install `husky` to help us use git and npm hooks

> [husky hooks](https://github.com/typicode/husky/blob/master/HOOKS.md)

```bash
yarn add husky --dev
```

## Install `commitlint`

> [commitlint](https://github.com/marionebl/commitlint#getting-started)

### Installation
```bash
# Install commitlint cli and angular config
yarn add --dev @commitlint/{config-conventional,cli}
# For Windows:
yarn add --dev @commitlint/config-conventional @commitlint/cli

# Configure commitlint to use angular config
echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js
```

### Configuration
```json
{
  "scripts": {
    "commitmsg": "commitlint -e $GIT_PARAMS"
  }
}
```

# Generate ChangeLog
## Install `conventional-changelog-cli`
```bash
yarn add --dev conventional-changelog-cli
```

## Configuration
```json
{
  "scripts": {
    "version": "conventional-changelog -p angular -i CHANGELOG.md -s -r 0 && git add CHANGELOG.md"
  }
}
```

# Branch Management

该分支模型值得借鉴的地方包括

- 规范的分支命名
- 将分支和代码运行环境关联起来

分支和代码运行环境的关系是这样的，

- master => 生产环境
- release/*，hotfix/* => 预上线环境
- feature/*，develop => 开发环境

# `git flow` Installation

## Mac

```bash
brew install git-flow
```

## Linux

```bash
curl -OL https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh
chmod +x gitflow-installer.sh
sudo ./gitflow-installer.sh
```

# Refs
- [Commit message 和 Change log 编写指南](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)
- [git仓库删除所有提交历史记录，成为一个干净的新仓库](https://yuhongjun.github.io/tech/2017/04/28/git%E4%BB%93%E5%BA%93%E5%88%A0%E9%99%A4%E6%89%80%E6%9C%89%E6%8F%90%E4%BA%A4%E5%8E%86%E5%8F%B2%E8%AE%B0%E5%BD%95-%E6%88%90%E4%B8%BA%E4%B8%80%E4%B8%AA%E5%B9%B2%E5%87%80%E7%9A%84%E6%96%B0%E4%BB%93%E5%BA%93.html)

