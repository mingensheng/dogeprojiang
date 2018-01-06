#include "../dir1/testPointer.h"

int testFuncPtr(int (*funcp) (int, int), int a);

float testVoidPtr(void *ptr);

int testPtrs(struct foo *fooPtr, char* arr);

char testArray(char arr[]);
