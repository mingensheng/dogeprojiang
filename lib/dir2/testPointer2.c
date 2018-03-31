//
//  testPointer2.c
//  testSourceCode
//
//  Created by Yilin Chen on 2018-01-11.
//  Copyright © 2018 Yilin Chen. All rights reserved.
//

#include "testPointer2.h"
#include "../dir1/testPointer.h"

float testVoidPtr(void *ptr)
{
    struct foo* fooPtr = (struct foo*)ptr;
    float ret = -1;
    if (fooPtr->foo1 * fooPtr->foo2 > 100)
        ret = (fooPtr->foo1 + fooPtr->foo2)/10;
    else
        ret = fooPtr->foo1 + fooPtr->foo2;
    return ret;
}

int testPtrs(struct foo *fooPtr, char* arr)
{
    if (*(arr + fooPtr->foo1) == *(arr + fooPtr->foo2))
        return 1;
    else
        return -1;
}

char testArray(char arr[])
{
    int i = 0;
    char ret = arr[0];
    while (arr[i] != 'T')
    {
        ret = arr[i-1];
        i++;
    }
    return ret;
}
