/*
  Chapter -1.2

*/

#include <stdio.h>

#define LOWER 0
#define UPPER 300
#define STEP 20

int main() {
  float celsius = 0;
  float fahr = 0;

  printf("Fahrenheit\tCelsius\n");
  while (fahr <= UPPER) {
    celsius = 5.0 * (fahr - 32) / 9.0;
    printf("%.f\t\t%.1f\n", fahr, celsius);
    fahr += STEP;
  }
}
