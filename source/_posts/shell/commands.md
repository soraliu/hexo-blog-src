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

# tar unzip
# notice: This will be extracted to /src/to/be/zipped
# not /zipped
tar -xzf /path/to/archive.zip -C /
```





<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEzMzg5OTg3MDUsLTE5MjY5MDMzNjgsLT
MzNjA3MTIsMjEyNjI1MDM3NywzNTkyODM5MDNdfQ==
-->