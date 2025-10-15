#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <foldername>"
  exit 1
fi

FOLDER="$1"
TEXT="$2"
SRC="$FOLDER/main.c"
OUT="$FOLDER/main"

if [ ! -d "$FOLDER" ]; then
  mkdir -p "$FOLDER"

  EX_NUM="${FOLDER#e}"

  cat > "$SRC" <<EOL
/* 
  Exercise $EX_NUM
  $TEXT
*/

#include <stdio.h>

int main() {
  
}
EOL

  echo "folder $FOLDER and file main.c created!"
fi

if [ ! -f "$SRC" ]; then
  echo "Datei $SRC existiert nicht!"
  exit 1
fi

gcc "$SRC" -o "$OUT"
if [ $? -ne 0 ]; then
  echo "Kompilierung fehlgeschlagen."
  exit 1
fi

"$OUT"
