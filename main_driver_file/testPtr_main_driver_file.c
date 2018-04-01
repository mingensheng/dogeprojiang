#include <klee/klee.h> 
#include <stdio.h> 
//!!!!!!!!!!!!!function:testPtris not found
#include "/home/klee/dogeprojiang/lib/dir1/testPointer.h"

int main(int argc, char** argv) { 

//int testPtr(char* ptr);
char ptr;
klee_make_symbolic(&ptr, sizeof(ptr), "ptr");
int output = testPtr(& ptr);
printf("output:%d \n", output);
return testPtr(& ptr);


} 
