# the compiler to use
CC = clang

# compiler flags:
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings
CFLAGS  = -c -g

# directories to include
#INC_DIRS := ../dir1
#INC_FLAGS := $(addprefix -I,$(INC_DIRS))
#files to link:
#LFLAGS = 

TARGET = testPointer2

all: $(TARGET)
$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) $(TARGET).c