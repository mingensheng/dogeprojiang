#include <klee/klee.h> 

int main(int argc, char** argv) { 

//int testChar(char a);
char a;
klee_make_symbolic(&a, sizeof(a), "a");
int output = testChar(a);
printf("output:%d \n", output);
return testChar(a);


} 
