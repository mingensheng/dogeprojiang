#include <klee/klee.h> 

int main() { 

//int testCombo9(function func, void* ptr);
function func = malloc(sizeof (function));
klee_make_symbolic(&func, sizeof(func), "func");
void* ptr = malloc(sizeof (void));
klee_make_symbolic(&ptr, sizeof(ptr), "ptr");
testCombo9(func, ptr);


} 
