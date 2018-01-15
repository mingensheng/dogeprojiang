#include <klee/klee.h> 

int main() { 

//float testVoidPtr(void *ptr);
void *ptr = malloc(sizeof (void));
klee_make_symbolic(&ptr, sizeof(ptr), "ptr");
testVoidPtr(ptr);


} 
