#include <stdio.h>
#include <limits.h>

int main() {

  printf("The number of bits in a byte (char) %d\n", CHAR_BIT);

  printf("The minimum value of SIGNED CHAR = %d\n", SCHAR_MIN);
  printf("The maximum value of SIGNED CHAR = %d\n", SCHAR_MAX);
  printf("The minimum value of CHAR = %d\n", CHAR_MIN);
  printf("The maximum value of CHAR = %d\n", CHAR_MAX);
  printf("The maximum value of UNSIGNED CHAR = %u\n", UCHAR_MAX);

  printf("The minimum value of SHORT INT = %d\n", SHRT_MIN);
  printf("The maximum value of SHORT INT = %d\n", SHRT_MAX);
  printf("The maximum value of UNSIGNED SHORT INT = %u\n", USHRT_MAX);
  
  printf("The minimum value of INT = %d\n", INT_MIN);
  printf("The maximum value of INT = %d\n", INT_MAX);
  printf("The maximum value of UNSIGNED INT = %u\n", UINT_MAX);

  printf("The minimum value of LONG INT = %ld\n", LONG_MIN);
  printf("The maximum value of LONG INT = %ld\n", LONG_MAX);
  printf("The maximum value of UNSIGNED LONG INT = %lu\n", ULONG_MAX);

  printf("The maximum value of LONG LONG INT = %lld\n", LLONG_MAX);
  printf("The minimum value of LONG LONG INT = %lld\n", LLONG_MIN);
  printf("The maximum value of UNSIGNED LONG LONG INT = %llu\n", ULLONG_MAX);
  
  return(0);
}
