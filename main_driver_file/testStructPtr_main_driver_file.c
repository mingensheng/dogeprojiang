#include <klee/klee.h> 

int main() { 

//int testStructPtr(struct foo *foo_ptr);
struct foo *foo_ptr = malloc(sizeof (struct foo));
klee_make_symbolic(&foo_ptr, sizeof(foo_ptr), "foo_ptr");
testStructPtr(foo_ptr);


} 
