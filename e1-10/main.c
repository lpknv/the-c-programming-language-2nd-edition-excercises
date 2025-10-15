#include <stdio.h>

int main() {

  /*
    Exercise 1-10.
    Write a program to copy its input to its output, replacing
    each tab by \t, each backspace by \b, and each backslash by \\. This makes
    tabs and backspaces visible in an unambiguous way.
  */

  int c = 0;
  int last_was_blank = 0;

  while ((c = getchar()) != EOF) {
    switch (c) {
    case '\n':
      putchar('\\');
      putchar('n');
      break;
    case '\t':
      putchar('\\');
      putchar('t');
      break;
    default:
      printf("%c", c);
    }
  }

  return 0;
}
