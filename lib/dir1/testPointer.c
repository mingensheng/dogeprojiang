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
    if (ptr[0] == 'a')
        return 1;
    else
        return 0;
}
/*
int testStructPtr(struct foo *foo_ptr)
{
    int c = foo_ptr->foo1 + foo_ptr->foo2;
    if (c > 100)
        return foo_ptr->func_pointer(foo_ptr->foo1, foo_ptr->foo2);
    else
        return -1;
}
*/
int testSwitch (int a, int b)
{
    int output = 10;
    switch(a%b) {
        case 0 :
            output = 0;
            break;
        case 1 :
            output = 1;
            break;
        case 2 :
            output = 2;
            break;
        default :
        output = 10;
    }
    return output;
}
