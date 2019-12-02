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


<!--stackedit_data:
eyJoaXN0b3J5IjpbMTk2Njk3MDU5NSwtMTMzODk5ODcwNSwtMT
kyNjkwMzM2OCwtMzM2MDcxMiwyMTI2MjUwMzc3LDM1OTI4Mzkw
M119
-->