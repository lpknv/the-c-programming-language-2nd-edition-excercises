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
        TEXT="$TEXT $arg"
      fi
      ;;
  esac
done

SRC="$FOLDER/$PROGRAM_NAME.c"
OUT="$FOLDER/$PROGRAM_NAME"

# Ordner und Datei erstellen, falls sie nicht existieren
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

  echo "Folder $FOLDER and file main.c created!"
fi

# Prüfen, ob die Quelldatei existiert
if [ ! -f "$SRC" ]; then
  echo "Datei $SRC existiert nicht!"
  exit 1
fi

# Assembly oder normale Kompilierung
if [ $ONLY_ASSEMBLY -eq 1 ]; then
  gcc -S -g -fverbose-asm "$SRC" -o "$OUT".s
  gcc -c "$OUT".s -o "$OUT".o
  gcc "$OUT".o -o "$OUT"
  "$OUT"

  if [ $? -ne 0 ]; then
    echo "Assembly-Erzeugung fehlgeschlagen."
    exit 1
  fi
  echo "Assembly wurde erzeugt: $OUT.s"
else
  gcc "$SRC" -o "$OUT"
  if [ $? -ne 0 ]; then
    echo "Kompilierung fehlgeschlagen."
    exit 1
  fi
  echo "Programm kompiliert: $OUT"
  "$OUT"
fi
