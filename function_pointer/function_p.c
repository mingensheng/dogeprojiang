#include <stdlib.h>
#include <stdio.h>
# include <klee/klee.h>

int add (int a, int b)
{
    return a+b;
}

typedef int (*function)(int a, int b);

struct foo{
    int foo1;
    int foo2;
    function func_pointer;
} ;

int bar(struct foo *foo_ptr_temp){
  //struct foo *foo_ptr_temp = (struct foo*) foo_ptr ;
  foo_ptr_temp->func_pointer = &add;
  int sum = foo_ptr_temp->func_pointer(foo_ptr_temp->foo1, foo_ptr_temp->foo2);
  
  if(sum > 5){
    return 8;
  }
  else{
    return 10;
  }
}


int main (){  
  struct foo *foo_ptr = malloc(sizeof (struct foo));
  //(void*)foo_ptr;
  klee_make_symbolic(foo_ptr, sizeof(struct foo), "foo");
  return bar(foo_ptr);
}
