#include <klee/klee.h> 
#include <stdio.h> 
#include "/home/klee/dogeprojiang/lib/testPrimitives.h"

int main(int argc, char** argv) { 

//int testFloat(float a);
float a;
klee_make_symbolic(&a, sizeof(a), "a");
int output = testFloat(a);
printf("output:%d \n", output);
return testFloat(a);


} 
