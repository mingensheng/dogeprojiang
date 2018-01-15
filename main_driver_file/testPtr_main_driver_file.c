#include <klee/klee.h> 

int main() { 

//int testPtr(char* ptr);
char* ptr = malloc(sizeof (char));
klee_make_symbolic(&ptr, sizeof(ptr), "ptr");
testPtr(ptr);


//int testPtrs(struct foo *fooPtr, char* arr);
struct foo *fooPtr = malloc(sizeof (struct foo));
klee_make_symbolic(&fooPtr, sizeof(fooPtr), "fooPtr");
char* arr = malloc(sizeof (char));
klee_make_symbolic(&arr, sizeof(arr), "arr");
testPtr(fooPtr, arr);


} 
