#include <stdio.h>

int _strlen(char *s) {
  int n;

  for (n = 0; *s != '\0'; s++)
    n++;
  return n;
}

int main() {

  int c = _strlen("hello world");

  printf("%d\n", c);

  int a[10];
  int *pa;
  a[0] = 22;
  pa = &a[0];

  pa + 1;

  printf("%d", *pa);

  return 0;
}
