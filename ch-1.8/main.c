/*
  Chapter 1.8
  Arguments - Call by Value
*/

#include <stdio.h>

int power(int base, int n) {
  int p;
  for (p = 1; n > 0; --n)
    p = p * base;
  return p;
}

int main() {
  int p = power(2, 3);

  printf("Power of 2,3 = %d\n", p);
}
