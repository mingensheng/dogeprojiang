# the compiler to use
CC = clang

# compiler flags:
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings
CFLAGS  = -c -g

#files to link:
#LFLAGS = 
TARGET = testPrimitives

all: $(TARGET)
$(TARGET): $(TARGET).c
	cd dir1 && $(MAKE)
	cd dir2 && $(MAKE)
	$(CC) $(CFLAGS) $(TARGET).c

clean:
	find . -name "*.o" -type f -delete