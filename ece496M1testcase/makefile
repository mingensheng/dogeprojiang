# the compiler to use
CC = clang

# compiler flags:
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings
CFLAGS  = -c -g


#files to link:
LFLAGS = $(shell find . -name "*.o" -type f)

TARGET = $(target)

all: $(TARGET)
$(TARGET): $(TARGET).c
	cd lib && $(MAKE)
	$(CC) $(CFLAGS) $(TARGET).c
	$(CC) -o $(TARGET) $(TARGET).o $(LFLAGS)

clean:
	find . -name "*.o" -type f -delete
	rm -f main1
