#include <klee/klee.h> 

int main() { 

//int testFloat(float a);
float a = malloc(sizeof (float));
klee_make_symbolic(&a, sizeof(a), "a");
testFloat(a);


} 
