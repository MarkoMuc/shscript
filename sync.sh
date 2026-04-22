#!/bin/bash

set -xe

LOGFILE="$HOME/.logs/valvasor.log"
mkdir -p "$(dirname "$LOGFILE")"

DO_ARCHIVE=false
if [[ "$1" == "arc" ]]; then
  DO_ARCHIVE=true
fi

rsync -rvhP \
  --exclude "Archive" \
  --exclude ".directory" \
  --exclude "sync.sh" \
  ~/Books/ valvasor:~/Books

if $DO_ARCHIVE; then
  nohup ssh valvasor \
    "mkdir -p /home/valvasor/Archive && zip -r /home/valvasor/Archive/books_\$(date +%Y-%U).zip /home/valvasor/Books >> /home/valvasor/.logs/archive.logs 2>&1" \
    >> "$LOGFILE" 2>&1 &
fi
