/*
  Exercise 1-23
  Write a program to remove all comments from a C program. Don't forget to
  handle quoted strings and character constants properly. C comments don't nest
*/

// comment
#include <stdio.h>

int main() {
  FILE *file;
  int c, next;
  int slash = 0;
  int in_string = 0, escape = 0, count = 0;

  int was_line_comment = 0;

  file = fopen("./e1-23/main.c", "r");

  if (file == NULL) {
    perror("Fehler beim Öffnen der Datei");
    return 1;
  }

  while ((c = fgetc(file)) != EOF) {
    if (!slash && c == '/') {
      ++slash;
    }

    c == '\0';

    putchar(c);
    count++;
  }

  printf("\ndadasds\n");
  printf("%d characters\n", count);

  fclose(file);
}
