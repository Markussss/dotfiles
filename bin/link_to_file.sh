#!/bin/bash

# https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda

while read line
do
  check=`echo $line | sed 's/\x1B[@A-Z\\\]^_]\|\x1B\[[0-9:;<=>?]*[-!"#$%&'"'"'()*+,.\/]*[][\\@A-Z^_\`a-z{|}~]//g'`
  if [ -f "$check" ]; then
    url="file:$(pwd)/$check"
    printf "\e]8;;$url\e\\$line\e]8;;\e\\"
    echo
  else
    echo "$line"
  fi
done;