//
//  testPointer2.h
//  testSourceCode
//
//  Created by Yilin Chen on 2018-01-11.
//  Copyright © 2018 Yilin Chen. All rights reserved.
//

#ifndef testPointer2_h
#define testPointer2_h

#include <stdio.h>
#include "../dir1/testPointer.h"

float testVoidPtr(void *ptr);

int testPtrs(struct foo *fooPtr, char* arr);

char testArray(char arr[]);

#endif /* testPointer2_h */
