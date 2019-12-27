---
title: The deps manager of go lang
date: 2019-12-27 17:20:09
tags:
- go
- dep
---

## go mod

[Go Modules](https://github.com/golang/go/wiki/Modules) have recently been released and announced as the official Go dependency management tool. A lot of Go 3rd libraries are being migrated to use Go Modules and require dependent projects to use Go Modules as well. Therefore, Go Dep is going to be deprecated soon. We will swap Dep for Go Modules in the project we previously started

## Features

-   Allow and recommend projects to be located outside of  `$GOPATH`.
-   Dependencies are put into a  `vendor`  directory (same as  `go-dep`), so that different projects can depend on different versions of the same packages.
-   Automatically detect import statements and then update dependencies graph, lock, download, and install appropriate versions of packages.
-   Automatically check for dependencies when  `build`,  `run`, or  `test`.
-   Allow specifying, downgrading, and upgrading versions of packages.
-   Automatically generate a dependency lock to ensure reproducible builds.
-   Semantic versioning mechanism.
-   The official recommendation for dependencies and applied in the Go ecosystem.

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE1NDU0OTI3OCwtMTU3MjIzNjU2OF19
-->