#include <klee/klee.h> 

int main() { 

//int testCombo7(int a, char* b, char c[], struct foo *fooPtr);
int a = malloc(sizeof (int));
klee_make_symbolic(&a, sizeof(a), "a");
char* b = malloc(sizeof (char));
klee_make_symbolic(&b, sizeof(b), "b");
char c[] = malloc(sizeof (char));
klee_make_symbolic(&c[], sizeof(c[]), "c[]");
struct foo *fooPtr = malloc(sizeof (struct foo));
klee_make_symbolic(&fooPtr, sizeof(fooPtr), "fooPtr");
testCombo7(a, b, c[], fooPtr);


} 
