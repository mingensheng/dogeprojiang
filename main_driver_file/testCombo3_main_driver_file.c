#include <klee/klee.h> 

int main() { 

//float testCombo3(struct foo *fooPtr, function func);
struct foo *fooPtr = malloc(sizeof (struct foo));
klee_make_symbolic(&fooPtr, sizeof(fooPtr), "fooPtr");
function func = malloc(sizeof (function));
klee_make_symbolic(&func, sizeof(func), "func");
testCombo3(fooPtr, func);


} 
