/*
  Exercise 1-20
  Write a program detab that replaces tabs in the input with the proper number
  of blanks to space to the next tab stop. Assume a fixed set of tab stops, say
  every n columns. Should n be a variable or a symbolic parameter?
*/

#include <stdio.h>

#define TABWIDTH 4

int main() {
  int column = 0;
  int spaces = 0;

  int c;

  while ((c = getchar()) != EOF) {
    if (c == '\t') {
      spaces = TABWIDTH - (column % TABWIDTH);
      for (int i = 0; i < spaces; i++)
        putchar(' ');
      column += spaces;
    } else if (c == '\n') {
      putchar('\n');
      column = 0;
    } else {
      putchar(c);
      column++;
    }
  }
}
