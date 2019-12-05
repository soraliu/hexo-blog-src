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

## Network

```bash
# check whether the site is healthy
curl -if https://xxx.xx/health-check
```

## String

```bash
# cut
  # get Add and Modified files
git diff-tree --no-commit-id --name-status -r HEAD | grep '^[AM]' | cut -f 2

# regex

```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEyMDcyOTM2MzMsLTgzMTYwNDI3MSwxOT
Y2OTcwNTk1LC0xMzM4OTk4NzA1LC0xOTI2OTAzMzY4LC0zMzYw
NzEyLDIxMjYyNTAzNzcsMzU5MjgzOTAzXX0=
-->