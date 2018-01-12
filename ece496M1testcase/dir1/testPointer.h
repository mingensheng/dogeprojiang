//
//  testPointer.h
//  testSourceCode
//
//  Created by Yilin Chen on 2018-01-11.
//  Copyright © 2018 Yilin Chen. All rights reserved.
//

#ifndef testPointer_h
#define testPointer_h

#include <stdio.h>

typedef int (*function)(int a, int b);

struct foo{
    int foo1;
    int foo2;
    function func_pointer;
} ;

int testPtr(char* ptr);

int testStructPtr(struct foo *foo_ptr);

int testFuncPtr (int a, function call_back, int b);

#endif /* testPointer_h */
