/*
  Chapter -1.2

*/

#include <stdio.h>

#define LOWER 0
#define UPPER 300
#define STEP 20

void calc() {
  int celsius = 0;
  int fahr = 0;

  while (fahr <= UPPER) {
    celsius = 5 * (fahr - 32) / 9;
    printf("%d\t%d\n", fahr, celsius);
    fahr = fahr + STEP;
  }
}

int main() { calc(); }
