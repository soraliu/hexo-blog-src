---
title: k8s pvc subPath
date:
tag:
- k8s
- volume
- subPath
---

### 我们希望将文件挂载到某个目录，但希望只是挂载该文件，不要影响挂载目录下的其他文件。有办法吗？

> subPath 的目的是为了在单一Pod中多次使用同一个volume而设计的。

 `subPath`: `Path within the volume from which the container's volume should be mounted`。

```yaml

```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTExMzg2ODA1ODldfQ==
-->