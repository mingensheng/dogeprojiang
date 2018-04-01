#include <klee/klee.h> 
#include <stdio.h> 
#include "/home/klee/dogeprojiang/lib/testPrimitives.h"

int main(int argc, char** argv) { 

//char testDouble(double a);
double a;
klee_make_symbolic(&a, sizeof(a), "a");
//return type is not supoorted by KLEE tool;
return testDouble(a);


} 
