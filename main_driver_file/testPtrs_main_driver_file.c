#include <klee/klee.h> 

int main() { 

//int testPtrs(struct foo *fooPtr, char* arr);
struct foo *fooPtr = malloc(sizeof (struct foo));
klee_make_symbolic(&fooPtr, sizeof(fooPtr), "fooPtr");
char* arr = malloc(sizeof (char));
klee_make_symbolic(&arr, sizeof(arr), "arr");
testPtrs(fooPtr, arr);


} 
