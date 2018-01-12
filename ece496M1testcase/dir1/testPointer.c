//
//  testPointer.c
//  testSourceCode
//
//  Created by Yilin Chen on 2018-01-11.
//  Copyright © 2018 Yilin Chen. All rights reserved.
//

#include "testPointer.h"

int testPtr(char* ptr)
{
    if (ptr != NULL)
        return 1;
    else
        return 0;
}

int testStructPtr(struct foo *foo_ptr)
{
    int c = foo_ptr->foo1 + foo_ptr->foo2;
    if (c > 100)
        return foo_ptr->func_pointer(foo_ptr->foo1, foo_ptr->foo2);
    else
        return -1;
}

int testFuncPtr (int a, function call_back, int b)
{
    int c = a + b;
    if (c > 0)
        return call_back(a, b);
    else
        return -1;
}
