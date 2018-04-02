//
//  testCombinations.h
//  testSourceCode
//
//  Created by Yilin Chen on 2018-01-11.
//  Copyright © 2018 Yilin Chen. All rights reserved.
//

#ifndef testCombinations_h
#define testCombinations_h

#include <stdio.h>
#include "../testPointer.h"

//int max=10;

void testCombo1(int a, float b, char c);

int testCombo2(char a[], int b[], int* c);

int testCombo3(struct foo *fooPtr);

int testBranch(int a, int b, char opt);

char* testCombo4(void* ptr);

int testCombo5(struct foo *fooPtr);

char* testCombo6(char a[], float b, function func);

int testCombo7(int a, char* b, char c[], struct foo *fooPtr);

int testCombo8(void* ptr, char* b);

int testCombo9(function func, void* ptr);

#endif /* testCombinations_h */
