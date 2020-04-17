// This program aims to detect whether the stack is growing upward or downward
// If local varaible in callee is below local varaible in caller, the stack
// grows downward. Otherwise, stack grows upward.
//
// Some people point out it is undefined behavior for relational operator "-"
// if we subtract two pointers pointing to different structure. In other words,
// C doesn't provide your tool to investigate your own stack.

// Ref:
// - https://stackoverflow.com/questions/664744/what-is-the-direction-of-stack-growth-in-most-modern-systems/664779#664779
// - https://stackoverflow.com/questions/1677415/does-stack-grow-upward-or-downward
// - https://www.geeksforgeeks.org/c-program-find-direction-growth-stack/

#include <stdio.h>

int* callee()
{
  int x = 4;
  return &x;
}

void caller()
{
  int* p = callee();
  int y = 4;
  int *q = &y;
  printf("local variable address in callee: %p\n", p);
  printf("local varaible address in caller: %p\n", q);
  if (q - p > 0)
  {
    printf("grows downward!");
  }
  else
  {
    printf("grows upward!");
  }
}

int main()
{
  caller();
}
