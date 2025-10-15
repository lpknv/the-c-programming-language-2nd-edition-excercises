#!/bin/bash

clear

if [ $# -lt 1 ]; then
  echo "Usage: $0 <foldername> [-asm] [description]"
  exit 1
fi

FOLDER=""
TEXT=""
ONLY_ASSEMBLY=0
PROGRAM_NAME="main"

for arg in "$@"; do
  case "$arg" in
    -asm)
      ONLY_ASSEMBLY=1
      ;;
    *)
      if [ -z "$FOLDER" ]; then
        FOLDER="$arg"
      else
        if [ -z "$TEXT" ]; then
          TEXT="$arg"
        else
          TEXT="$TEXT $arg"
        fi
      fi
      ;;
  esac
done

SRC="$FOLDER/$PROGRAM_NAME.c"
OUT="$FOLDER/$PROGRAM_NAME"

mkdir -p "$FOLDER"

LABEL="Exercise"
EX_NUM="${FOLDER#*[!0-9]}"

if [[ "$FOLDER" =~ ^[Cc][Hh]([0-9\-]+) ]]; then
  LABEL="Chapter"
  EX_NUM="${BASH_REMATCH[1]}"
elif [[ "$FOLDER" =~ ^[Ee]([0-9\-]+) ]]; then
  LABEL="Exercise"
  EX_NUM="${BASH_REMATCH[1]}"
fi

if [ ! -f "$SRC" ]; then
  cat > "$SRC" <<EOL
/* 
  $LABEL $EX_NUM
  $TEXT
*/

#include <stdio.h>

int main() {

}
EOL
  echo "File $SRC created!"
else
  echo "File $SRC already exists — skipping creation."
fi

if [ $ONLY_ASSEMBLY -eq 1 ]; then
  echo "→ creating assembly file with debug info..."
  gcc -S -g -fverbose-asm "$SRC" -o "$OUT".s
  gcc -c "$OUT".s -o "$OUT".o
  gcc "$OUT".o -o "$OUT"
  "$OUT"

  if [ $? -ne 0 ]; then
    echo "❌ Failed to create assembly file."
    exit 1
  fi
  echo "✅ assembly file created: $OUT.s"
else
  echo "→ Compile $SRC..."
  gcc "$SRC" -o "$OUT"
  if [ $? -ne 0 ]; then
    echo "❌ Failed to compile."
    exit 1
  fi
  "$OUT"
  echo "✅ Compiled: $OUT"
fi
