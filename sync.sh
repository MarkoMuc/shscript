#!/bin/bash

set -xe

LOGFILE="$HOME/.logs/alexandria.log"
mkdir -p "$(dirname "$LOGFILE")"

rsync -rvhP \
  --exclude "Archive" \
  --exclude ".directory" \
  --exclude "sync.sh" \
  ~/Books/ alexandria:~/Books

nohup ssh alexandria \
  "mkdir -p /home/alexandria/Archive && zip -r /home/alexandria/Archive/books_\$(date +%V)_\$(date +%Y).zip /home/alexandria/Books >> /home/alexandria/archive.logs 2>&1" \
  >> "$LOGFILE" 2>&1 &
