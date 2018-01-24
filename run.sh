#!/usr/bin/env bash

if which -s imgcat; then
  viewer=imgcat
else
  viewer=open
fi

header() {
  if [[ -n "$2" ]]; then
    echo
  fi
  echo -e "\033[35m$1\033[0m"
}

ruby example.rb &&
  header 'MESSAGES RECORDED:' &&
  cat recorded.json &&
  ruby draw.rb <recorded.json >graph.png &&
  header 'IMAGE GENERATED: graph.png' 1 &&
  $viewer graph.png
