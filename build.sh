#!/bin/bash

clear

# Prüfen, ob mindestens ein Parameter übergeben wurde
if [ $# -lt 1 ]; then
  echo "Usage: $0 <foldername> [-asm] [description]"
  exit 1
fi

FOLDER=""
TEXT=""
ONLY_ASSEMBLY=0
PROGRAM_NAME="main"

# Alle Parameter auswerten
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

# Ordner erstellen, falls nicht vorhanden
mkdir -p "$FOLDER"

# Bezeichnung (Exercise oder Chapter) bestimmen
LABEL="Exercise"
EX_NUM="${FOLDER#*[!0-9]}"

if [[ "$FOLDER" =~ ^[Cc][Hh]([0-9\-]+) ]]; then
  LABEL="Chapter"
  EX_NUM="${BASH_REMATCH[1]}"
elif [[ "$FOLDER" =~ ^[Ee]([0-9\-]+) ]]; then
  LABEL="Exercise"
  EX_NUM="${BASH_REMATCH[1]}"
fi

# Falls main.c nicht existiert → erzeugen
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

# Assembly oder normale Kompilierung
if [ $ONLY_ASSEMBLY -eq 1 ]; then
  echo "→ Erzeuge Assembly mit Debug-Infos..."
  gcc -S -g -fverbose-asm "$SRC" -o "$OUT".s
  gcc -c "$OUT".s -o "$OUT".o
  gcc "$OUT".o -o "$OUT"
  "$OUT"

  if [ $? -ne 0 ]; then
    echo "❌ Assembly-Erzeugung fehlgeschlagen."
    exit 1
  fi
  echo "✅ Assembly wurde erzeugt: $OUT.s"
else
  echo "→ Compile $SRC..."
  gcc "$SRC" -o "$OUT"
  if [ $? -ne 0 ]; then
    echo "❌ Kompilierung fehlgeschlagen."
    exit 1
  fi
  "$OUT"
  echo "✅ Compiled: $OUT"
fi
