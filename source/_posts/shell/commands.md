---
title: Shell Common Commands
date: 2019-11-25 15:00:31
tag:
- shell
- command
---

## Traverse
```bash
# read lines from file
while read line; do
  echo $line
done < /path/to/file
```

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
# base
# echo ${str:start-index} or echo ${str:start-index:length}
str='12345'
echo ${str:2} # 345
echo ${str:2:1} # 3
echo ${str: -2} # 45(there is a space beteew ':' and '-')

# cut
  # get Add and Modified files
git diff-tree --no-commit-id --name-status -r HEAD | grep '^[AM]' | cut -f 2

# rm last substring
filename=path-to-test-dev
str=$(echo ${filename%-*})
# path-to-test
echo $str

# regex
[[ "1234" =~ ^12 ]] && echo y

# trim
trim() {
    local var="$*"
    var="${var#"${var%%[![:space:]]*}"}"
    var="${var%"${var##*[![:space:]]}"}"
    echo -n "$var"
}
# 123 1221
trim ' 123 1221  '
```

## Process Subsititution

```bash
# grammar
# <(command) 或 >(command)
cat <(ls)
ls > >(cat)
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTM0MzUyMzAyNiw4NjY4NTg1NTAsMTcyMT
gwMTk2MiwtMTE2OTk2MTM5MCwtMTA0NjkxMzMzOSwtODMxNjA0
MjcxLDE5NjY5NzA1OTUsLTEzMzg5OTg3MDUsLTE5MjY5MDMzNj
gsLTMzNjA3MTIsMjEyNjI1MDM3NywzNTkyODM5MDNdfQ==
-->