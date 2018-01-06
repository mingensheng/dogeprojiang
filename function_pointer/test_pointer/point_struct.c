#include <stdlib.h>
#include <stdio.h>
# include <klee/klee.h>
struct foo{
    int foo1;
    int foo2;
} ;


int bar(struct foo *foo_ptr){

  if(foo_ptr->foo1 == 1){
    return 1;
  }
  else{
    return 2;
  }
}


int main (){  
  struct foo *foo_ptr = malloc(sizeof (struct foo));
  klee_make_symbolic(foo_ptr, sizeof foo_ptr, "foo");
  return bar(foo_ptr);
}
