struct foo{
    int foo1;
    int foo2;
    function func_pointer;
} ;

typedef int (*function)(int a, int b);

int testPtr(char* ptr);

int testStructPtr(struct foo *foo_ptr);

int testFuncPtr (int (*funcp) (int, int), int a);
