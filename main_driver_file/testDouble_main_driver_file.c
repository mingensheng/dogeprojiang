#include <klee/klee.h> 

int main() { 

//char testDouble(double a);
double a = malloc(sizeof (double));
klee_make_symbolic(&a, sizeof(a), "a");
testDouble(a);


} 
