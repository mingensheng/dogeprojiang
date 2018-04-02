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
} ;

typedef int bool;
#define true 1
#define false 0

int testPtr(char* ptr);

int testStructPtr(struct foo *foo_ptr);

int testSwitch (int a, int b);

#endif /* testPointer_h */
