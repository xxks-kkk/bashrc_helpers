/*
 * This program detects whether the endianness of the processor of the machine
 *
 * little endian: x86, AMD
 * big endian: ARM
 */

#include <stdint.h>
#include <stdio.h>

int main()
{
  // unsigned int with 16 bit
  uint16_t val = 0x400;
  // a unsigned 8-bit int ptr (i.e. ptr size is 8-bit)
  uint8_t* ptr = (uint8_t*) &val;

  if (ptr[0] == 0x04)
  {
    printf("big endian\n");
  }
  else if (ptr[1] == 0x04)
  {
    printf("little endian\n");
  }
  else
  {
    printf("unknown endianness\n");
  }
}
