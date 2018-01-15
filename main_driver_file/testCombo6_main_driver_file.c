#include <klee/klee.h> 

int main() { 

//char* testCombo6(char a[], float b, function func);
char a[] = malloc(sizeof (char));
klee_make_symbolic(&a[], sizeof(a[]), "a[]");
float b = malloc(sizeof (float));
klee_make_symbolic(&b, sizeof(b), "b");
function func = malloc(sizeof (function));
klee_make_symbolic(&func, sizeof(func), "func");
testCombo6(a[], b, func);


} 
