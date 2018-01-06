#include "../testPointer.h"

int max=10;

void testCombo1(int a, float b, char c);

int testCombo2(char a[], int b[], int* c);

float testCombo3(struct foo *fooPtr, int (*funcp) (int, int));

char* testCombo4(void* ptr);

struct foo* testCombo5(struct foo *fooPtr);

char* testCombo6(char a[], float b, int (*funcp) (int, int));

int testCombo7(int a, char* b, char[] c, struct foo *fooPtr);

int testCombo8(void* ptr, char* b);

int testCombo9(int (*funcp) (int, int), void* ptr);
