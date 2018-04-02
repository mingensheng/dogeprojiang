//
//  testPrimitives.c
//  testSourceCode
//
//  Created by Yilin Chen on 2018-01-11.
//  Copyright © 2018 Yilin Chen. All rights reserved.
//

#include "testPrimitives.h"
#include <stdio.h>
void testVoid()
{
    printf("Test void");
    return;
}

int testInt(int a, int b)
{
    if (a+b > 5)
        return a+b;
    else
        return 0;
}

int testChar(char a)
{
    if (a == 'a')
        return 1;
    else
        return 0;
}

int testFloat(float a)
{
    if (a > 100.0)
        return 1;
    else
        return 0;
}

char testDouble(double a)
{
    char ret = 't';
    if (a >= 20)
        ret = 'f';
    return ret;
}


