#!/bin/bash

set -xe

LOGFILE="$HOME/.logs/alexandria.log"
mkdir -p "$(dirname "$LOGFILE")"

DO_ARCHIVE=false
if [[ "$1" == "--archive" ]]; then
  DO_ARCHIVE=true
fi

rsync -rvhP \
  --exclude "Archive" \
  --exclude ".directory" \
  --exclude "sync.sh" \
  ~/Books/ alexandria:~/Books

if $DO_ARCHIVE; then
  nohup ssh alexandria \
    "mkdir -p /home/alexandria/Archive && zip -r /home/alexandria/Archive/books_\$(date +%Y-%m).zip /home/alexandria/Books >> /home/alexandria/archive.logs 2>&1" \
    >> "$LOGFILE" 2>&1 &
fi
