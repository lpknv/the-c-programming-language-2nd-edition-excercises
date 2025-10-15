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

  printf("\nFahrenheit\tCelsius (lower to upper)\n");
  while (fahr <= UPPER) {
    celsius = 5.0 * (fahr - 32) / 9.0;
    printf("%.f\t\t%.1f\n", fahr, celsius);
    fahr += STEP;
  }

  celsius = 0;
  fahr = UPPER;

  printf("\n\nFahrenheit\tCelsius (upper to lower)\n");
  while (fahr >= LOWER) {
    celsius = 5.0 * (fahr - 32) / 9.0;
    printf("%.f\t\t%.1f\n", fahr, celsius);
    fahr -= STEP;
  }
}
