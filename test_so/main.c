#include <stdio.h>
#include "foo.h"
#include <klee/klee.h>
int main(void)
{
    //puts("This is a shared library test...");
  int a;
  klee_make_symbolic(&a, sizeof(int), "a");

  return foo(a);
   
}
