#include <klee/klee.h> 

int main(int argc, char** argv) { 

//int testFloat(float a);
float a;
klee_make_symbolic(&a, sizeof(a), "a");
int output = testFloat(a);
printf("output:%d \n", output);
return testFloat(a);


} 
