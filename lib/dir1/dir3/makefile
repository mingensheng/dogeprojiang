# the compiler to use
CC = clang

# compiler flags:
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings
CFLAGS  = -emit-llvm -c -g
INC = /usr/lib/llvm-3.4/lib/clang/3.4/include/

#files to link:
#LFLAGS = 

TARGET = testCombinations

all: $(TARGET)
$(TARGET): $(TARGET).c
	$(CC) -I ${INC} $(CFLAGS) $(TARGET).c

