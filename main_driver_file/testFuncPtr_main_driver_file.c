#include <klee/klee.h> 

int main() { 

//int testFuncPtr (int a, function call_back, int b);
int a = malloc(sizeof (int));
klee_make_symbolic(&a, sizeof(a), "a");
function call_back = malloc(sizeof (function));
klee_make_symbolic(&call_back, sizeof(call_back), "call_back");
int b = malloc(sizeof (int));
klee_make_symbolic(&b, sizeof(b), "b");
testFuncPtr(a, call_back, b);


} 
