#!/bin/bash
for var in "a a" b c; do
  echo $var;
done

ROOT=$PWD;
echo '$PWD';
echo "$PWD";

createDir() {
  echo $before;
  echo $after;

  for arg in "$@"
  do
    DIR=$ROOT/$arg

    if [ -d $DIR ]; then
      echo "$DIR is already a directory";
    else
      read -p "create $DIR ? (Y/n)" isYes;

      if [[ "$isYes" = "Y" ]]||[[ ! $isYes ]]; then
        mkdir $DIR;
        echo "create $DIR success!";
      else
        echo "cancel create $DIR";
      fi
    fi
  done
}

before="before...";

createDir test

after="after...";


