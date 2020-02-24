---
title: Shell Common Commands
date: 2019-12-17 11:12:49
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

# curl: (48) An unknown option was passed in to libcurl
apk add curl-dev

# how to test gateway
kubectl -n istio-system port-forward svc/istio-ingressgateway 3000:80
curl -H "Host: www.xxx.com" http://localhost:3000
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

# keep str format
cat <<- EOF
w	1w	1wasdfc
...str
EOF
```

## JSON

```bash
# get json value
JSON='[{"a": "line\nnewline"}, {"a": "line1\nnewline"}]'
while read line; do
	echo $line | base64 --decode
done < <(echo $JSON | jq -r ".[].a | @base64")


# convert string to JSON
jq -aRs . <<< 'line
newline'

# use variable as JSON string
JSON_STRING='{"bucketname":"'"$BUCKET_NAME"'","objectname":"'"$OBJECT_NAME"'","targetlocation":"'"$TARGET_LOCATION"'"}'
```

## Date

```bash
date -D "2019-12-11T07:25:34Z" "+%Y-%m-%d %H:%M:%S"
```

## Process Subsititution

```bash
# grammar
# <(command) 或 >(command)
cat <(ls)
ls > >(cat)

while read -r line; do
  echo "$line"
done < <(ls)
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTk1OTczNjc2MSwxMDkwNzU5NDAzLC0xNz
gxNDA0MTM1LDk4MjM4OTY2OSwtMTk3ODYwNDk4Nyw1NzA4NDE5
OTQsLTI0NjgwNjA4MCwtMjE1NzM2MTQ1LDg2Njg1ODU1MCwxNz
IxODAxOTYyLC0xMTY5OTYxMzkwLC0xMDQ2OTEzMzM5LC04MzE2
MDQyNzEsMTk2Njk3MDU5NSwtMTMzODk5ODcwNSwtMTkyNjkwMz
M2OCwtMzM2MDcxMiwyMTI2MjUwMzc3LDM1OTI4MzkwM119
-->