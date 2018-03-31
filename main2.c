#include "lib/dir1/testPointer.h"
#include "klee/klee.h"
int main(int argc, char** argv){
    char a = 'a';
    char* p = &a;
    klee_make_symbolic(&p, sizeof p, "p");
    return testPtr(p);
}
