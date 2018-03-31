# the compiler to use
CC = clang

# compiler flags:
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings
CFLAGS  = -emit-llvm -c -g


#files to link:
#LFLAGS = 


	

TARGET = testPointer

all: $(TARGET)
$(TARGET): $(TARGET).c
	cd dir3 && $(MAKE)
	$(CC) $(CFLAGS) $(TARGET).c
