/*
  Chapter 5.4
  5.4 Address Arithmetic
*/

#include <stdio.h>

#define ALLOCSIZE 10000 /* size of available space */

static char allocbuff[ALLOCSIZE]; /* storage for alloc */
static char *allocp = allocbuff;  /* next free position */

char *alloc(int n) { /* return pointer to n characters */
  if (allocbuff + ALLOCSIZE - allocp >= n) { /* it fits */
    allocp += n;
    return allocp - n; /* old p */
  } else {             /* not enough room */
    return 0;
  }
}

void afree(char *p) {
  // set allocp to p if p is inside allocbuff
  if (p >= allocbuff && p < allocbuff + ALLOCSIZE)
    allocp = p;
}

int main() {}
