//
//  testCombinations.c
//  testSourceCode
//
//  Created by Yilin Chen on 2018-01-11.
//  Copyright © 2018 Yilin Chen. All rights reserved.
//

#include "testCombinations.h"
#include <stdlib.h>
#include "tgmath.h"

void testCombo1(int a, float b, char c)
{
    if (a+b > 0)
        return;
}

int testCombo2(char a[], int b[], int* c)
{
    int index = -1;
    int i = 0;
    for (i = 0; i < 10; i++)
    {
        if (*c == b[i])
            index = i;
    }
    return index;
}

float testCombo3(struct foo *fooPtr, function func)
{
    float ret = fooPtr->foo1 + fooPtr->foo2/100;
    if (func(fooPtr->foo1, fooPtr->foo2))
        return ret;
    else
        return -1;
}

char* testCombo4(void* ptr)
{
    if (ptr == NULL) return NULL;
    
    char* newPtr = malloc(5);
    struct foo *fooPtr = (struct foo*) ptr;
    int i = 0;
    for (i = 0; i < 5; i++)
    {
        if (fooPtr->func_pointer(fooPtr->foo1, fooPtr->foo2))
            *(newPtr+i) = 'T';
        else
            *(newPtr+i) = 'F';
    }
    return newPtr;
}

struct foo* testCombo5(struct foo *fooPtr)
{
    if (fooPtr == NULL)
        return NULL;
    
    struct foo* cp;
    cp = malloc(sizeof(struct foo));
    if (fooPtr->foo1 * fooPtr->foo2 < 100){
        cp->foo1 = fooPtr->foo1 * 2;
        cp->foo2 = fooPtr->foo2 * 2;
        cp->func_pointer = fooPtr->func_pointer;
    }
    else{
        cp->foo1 = fooPtr->foo1 - 10;
        cp->foo2 = fooPtr->foo2 - 10;
        cp->func_pointer = fooPtr->func_pointer;
    }
    return cp;
}

char* testCombo6(char a[], float b, function func)
{
    char* ptr = malloc((int)floor(b));
    int i = 0;
    for (i = 0; i < floor(b); i++)
    {
        if (a[i] == 'T' && func(i, floor(b)))
            *(ptr+i) = 'A';
        else
            *(ptr+i) = 'B';
    }
    return ptr;
}

int testCombo7(int a, char* b, char c[], struct foo *fooPtr)
{
    if(fooPtr->func_pointer == NULL) return -1;
    
    int total = 0;
    int i = 0;
    for(i = 0; i < a; i = i + 2)
    {
        if (c[i] == *b && c[i+1] == *b)
            total += fooPtr->func_pointer(i, i+1);
    }
    return total;
}

int testCombo8(void* ptr, char* b)
{
    char *charPtr = (char *)ptr;
    if(*b == *charPtr)
        return 1;
    else
        return 0;
}

int testCombo9(function func, void* ptr)
{
    if (ptr == NULL) return -1;
    
    struct foo* fooPtr = (struct foo *)ptr;
    return func(fooPtr->foo1, fooPtr->foo2);
}

