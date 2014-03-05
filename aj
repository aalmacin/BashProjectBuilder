#!/bin/sh
source makeEasel
main() {
  echo "Enter project title"
  read title
  if [[ $title = '' ]]; then
    echo "Invalid title"
    exit
  fi
  case $1 in
    '')
      makeEasel
      ;;
  esac
}
main
