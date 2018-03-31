#include <klee/klee.h> 

int main(int argc, char** argv) { 

//!!!!!!!!!!!!!function:testPtris not found
//int testPtr(char* ptr);
char ptr;
klee_make_symbolic(&ptr, sizeof(ptr), "ptr");
int output = testPtr(& ptr);
printf("output:%d \n", output);
return testPtr(& ptr);


} 
