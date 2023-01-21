#include <cpuid.h>

typedef struct {
  unsigned eax;
  unsigned ebx;
  unsigned ecx;
  unsigned edx;
} reg_t;

void
cpuid(reg_t *reg)
{
  __asm__ ("movl %4, %%eax\t\n"
          "movl %5, %%ecx\t\n"
          "cpuid\t\n"
          "movl %%eax, %0\t\n"
          "movl %%ebx, %1\t\n"
          "movl %%ecx, %2\t\n"
          "movl %%edx, %3\t\n"
          : "=r" (reg->eax), "=r" (reg->ebx),
            "=r" (reg->ecx), "=r" (reg->edx)
          : "r" (reg->eax), "r" (reg->ecx)
          );
}
