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

int testBranch(int a, int b, char opt){
    int output = 100;
    if(a%b){
        switch(opt)
        {
            case 'a':
                if(a>b)
                    output = 1;
                else
                    output = 2;
                break;
            case 'b':
                //if(a<b)
                    output = 3;
               /* else
                    output = 4;*/
                break;
            default:
                output = 0;
        }
    }
    else{
        switch(opt)
        {
            case 'a':
                if(a>b)
                    output = 4;
                else
                    output = 5;
                break;
            case 'b':
                if(a<b)
                    output = 6;
                else
                    output = 7;
                break;
            default:
                output = 0;
        }
    }
    return output;
}

int testCombo3(struct foo *fooPtr)
{
    int ret = fooPtr->foo1 + fooPtr->foo2;
    if (fooPtr->foo1 > fooPtr->foo2)
        return 1;
    else
        return 0;
}
/*
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
*/
int testCombo5(struct foo *fooPtr)
{
    if (fooPtr->foo1 * fooPtr->foo2 < 100){
        return 0;
    }
    else if (fooPtr->foo1 * fooPtr->foo2 < 500){
        return 1;
    }
    else if (fooPtr->foo1 * fooPtr->foo2 < 1000){
        return 2;
    }
    else
        return 3;
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
/*
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
*/
int testCombo8(void* ptr, char* b)
{
    char *charPtr = (char *)ptr;
    if(*b == *charPtr)
        return 1;
    else
        return 0;
}
/*
int testCombo9(function func, void* ptr)
{
    if (ptr == NULL) return -1;
    
    struct foo* fooPtr = (struct foo *)ptr;
    return func(fooPtr->foo1, fooPtr->foo2);
}
*/
