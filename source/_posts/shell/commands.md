---
title: Shell Common Commands
date: 2019-11-25 15:00:31
tag:
- shell
- command
---

## Volume

```bash
# Show Mounted Hard Drives Partition
df -aTh
```

## Task

```bash
# parallel run task
wget url1 &
wget url2 &
wait
```

```bash
# calc command time
time cp a_large_file .
```

## Compress

```bash
# tar zip
tar -czf /path/to/archive.zip /src/to/be/zipped
tar -xzf /path/to/archive.zip -C /
```





<!--stackedit_data:
eyJoaXN0b3J5IjpbMzcxMDUwOTQxLC0xOTI2OTAzMzY4LC0zMz
YwNzEyLDIxMjYyNTAzNzcsMzU5MjgzOTAzXX0=
-->