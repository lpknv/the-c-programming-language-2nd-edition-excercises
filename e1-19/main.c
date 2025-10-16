/*
  Exercise 1-19
  Write a function reverse(s) that reverses the character string s.
  Use it to write a program that reverses its input a line at a time.
*/

#include <stdio.h>
#include <string.h>

void reverse(char s[]) {
  int length = strlen(s);
  char temp[length + 1];

  // TODO: write reversed input a line at a line
  for (int i = 0; i < length; ++i) {
    temp[i] = s[length - 1 - i];
  }

  temp[length] = '\0';

  printf("%s\n", temp);
}

int main() {
  char str[] = "Hallo, Welt!";

  reverse(str);
  return 0;
}
