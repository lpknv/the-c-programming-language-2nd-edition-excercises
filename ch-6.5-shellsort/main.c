#include <stdio.h>

void shellsort(int v[], int n) {
  int gap, i, j, temp;

  for (gap = n/2; gap > 0; gap /= 2)
    for (i = gap; i < n; n++)
      for (j = i-gap; j >= 0 && v[j] > v[j+gap]; j -= gap) {
        temp = v[j];
        v[j] = v[j+gap];
        v[j+gap] = temp;
        printf("%d ", i);
      }
}

int main() {

  int test[3] = {33,2,1};
  shellsort(test, 22);

  return 0;
}
