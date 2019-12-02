---
title: The Cache of React Pipeline
date: 2019-12-02 11:41:02
tag:
- cache
- pipeline
---

## Build Cache
我们在做pipeline相关优化的时候，一个很重要的指标就是构建时间，最基本的优化就是构建缓存。

基本思路就是每次 `build` 之前 `restore` 上次的缓存，构建完成后 `rebuild` 当前缓存。

`cache` 我们试过几种种:
- node 上的 `volume`： EBS(RWO), EFS(RWX)等
- s3

EBS只支持 `ReadWriteOnly`, EFS支持 `ReadWriteMany`，由于我们的pipeline很可能会同时构建多次，所以需要支持 `RWX`  的 `EFS`，最开始我们在尝试的时候发现如果直接缓存不 `compress` 的话，传输性能存在瓶颈，总体构建时间反而降低，所以在上传之前我们先使用 tar (no compress) archive 一下。

```yaml
  steps:
  - name: restore-cache
    image: amazonlinux-cache
    workingDir: /workspace/src
    resources:
      requests:
        cpu: 2000m
    command:
    - /bin/sh
    args:
    - -c
    - |
      mkdir -p ${CACHE_FOLDER}
      export BUCKET_URL=s3://build-cache
      aws s3 cp ${BUCKET_URL}/$(inputs.params.REPO_NAME)/${NODE_MODULES_TAR_NAME} ${CACHE_FOLDER}/${NODE_MODULES_TAR_NAME} || true
      aws s3 cp ${BUCKET_URL}/$(inputs.params.REPO_NAME)/${BUILD_FILE_TAR_NAME} ${CACHE_FOLDER}/${BUILD_FILE_TAR_NAME} || true

      tar -xf ${CACHE_FOLDER}/${NODE_MODULES_TAR_NAME} -C / || true
      tar -xf ${CACHE_FOLDER}/${BUILD_FILE_TAR_NAME} -C / || true

  - name: build-from-src
    volumeMounts:
    - name: npmrc
      mountPath: /builder/home/
    image: node:12
    workingDir: /workspace/src
    resources:
      requests:
        cpu: 4000m
    command:
    - /bin/sh
    args:
    - -c
    - |
      [ -d /workspace/src/node_modules ] && echo "node_modules has been restored from cache" || echo "node_modules cache not found"
      [ -d /workspace/src/$(inputs.params.pathToBuildCache) ] && echo "$(inputs.params.pathToBuildCache) has been restored from cache\n" || echo "$(inputs.params.pathToBuildCache) cache not found\n"
      echo "start building..."

      $(inputs.params.buildCommands)

  - name: rebuild-cache
    image: amazonlinux-cache
    workingDir: /workspace/src
    resources:
      requests:
        cpu: 2000m
    env:
    - name: AWS_DEFAULT_REGION
      value: ap-northeast-1
    command:
    - /bin/sh
    args:
    - -c
    - |
      # check if skip
      if [ "$(inputs.params.skipRebuildCache)" == "true" ]; then
        echo 'rebuild cache is skipped'
        exit 0
      fi

      # tar
      export SRC_FOLDER=/workspace/src
      export NODE_MODULES_FOLDER=${SRC_FOLDER}/node_modules
      export BUILD_FOLDER=${SRC_FOLDER}/$(inputs.params.pathToBuildCache)

      mkdir -p ${CACHE_FOLDER}
      tar -cf ${CACHE_FOLDER}/${NODE_MODULES_TAR_NAME} ${NODE_MODULES_FOLDER} || true
      tar -cf ${CACHE_FOLDER}/${BUILD_FILE_TAR_NAME} ${BUILD_FOLDER} || true

      # upload
      export BUCKET_URL=s3://build-cache
      aws s3 cp ${CACHE_FOLDER}/${NODE_MODULES_TAR_NAME} ${BUCKET_URL}/$(inputs.params.REPO_NAME)/${NODE_MODULES_TAR_NAME}
      aws s3 cp ${CACHE_FOLDER}/${BUILD_FILE_TAR_NAME} ${BUCKET_URL}/$(inputs.params.REPO_NAME)/${BUILD_FILE_TAR_NAME}
```


### Resources

> [webpack build cache](https://webpack.js.org/configuration/other-options/#cache)
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwMTQwNDIxMDQsLTE1MjI3MDAzNDJdfQ
==
-->