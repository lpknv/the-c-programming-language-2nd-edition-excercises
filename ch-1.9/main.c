/*
  Chapter -1
  1.9 Character Arrays
*/

#include <stdio.h>
#define MAXLINE 1000

int getlinelength(char mystring[], int limit) {
  int character, i;

  for (i = 0;
       i < limit - 1 && (character = getchar()) != EOF && character != '\n';
       ++i)
    mystring[i] = character;
  if (character == '\n') {
    mystring[i] = character;
    ++i;
  }

  mystring[i] = '\0';
  return i;
}

/* copy: copy 'from' into 'to'; assume to is big enough */
void copy(char from[], char to[]) {
  int i = 0;
  while ((to[i] = from[i]) != '\0')
    ++i;
}

int main() {

  int length;                /* current line length */
  int max;                   /* maximum length seen so far */
  char line[MAXLINE];        /* current input line */
  char longestLine[MAXLINE]; /* longest line saved here */

  max = 0;

  while ((length = getlinelength(line, MAXLINE)) > 0)
    if (length > max) {
      max = length;
      copy(line, longestLine);
    }

  if (max > 0) /* there was a line */
    printf("%s", longestLine);
  return 0;
}
