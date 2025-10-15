#include <stdio.h>

int main() {

  /*
    Exercise 1-9.
    Write a program to copy its input to its output.
    Replace each string of one or more blanks by a single blank.
  */

  int c = 0, blanks = 0;
  int last_was_blank = 0;

  while ((c = getchar()) != EOF) {
    if (c == ' ') {
      if (!last_was_blank) {
        putchar(c);
        last_was_blank = 1;
      }
    } else {
      putchar(c);
      last_was_blank = 0;
    }
  }

  return 0;
}
