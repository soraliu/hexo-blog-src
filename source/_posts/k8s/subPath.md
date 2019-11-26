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
apiVersion: v1
kind: Pod
metadata:
  name: my-lamp-site
spec:
    containers:
    - name: mysql
      image: mysql
      env:
      - name: MYSQL_ROOT_PASSWORD
        value: "rootpasswd" 
      volumeMounts:
      - mountPath: /var/lib/mysql
        name: site-data
        subPath: mysql
    - name: php
      image: php:7.0-apache
      volumeMounts:
      - mountPath: /var/www/html
        name: site-data
        subPath: html
    volumes:
    - name: site-data
      persistentVolumeClaim:
        claimName: my-lamp-site-data
```


<!--stackedit_data:
eyJoaXN0b3J5IjpbMjgzMjAwODM1LDEzNzIwODIxNTFdfQ==
-->