#include <klee/klee.h> 

int main(int argc, char** argv) { 

//int testInt(int a, int b);
int a;
klee_make_symbolic(&a, sizeof(a), "a");
int b;
klee_make_symbolic(&b, sizeof(b), "b");
int output = testInt(a, b);
printf("output:%d \n", output);
return testInt(a, b);


} 
