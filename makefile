# the compiler to use
CC = clang
RPCC = gcc
GTCC = g++
# compiler flags:
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings
CFLAGS  = -emit-llvm -c -g
KLEEINC = -I /home/klee/klee_src/include/
LFLAGS = $(shell find ./lib -name "*.bc" -type f)

RPINC = -I /home/klee/klee_src/include/ 
RPLFLAG = -L /home/klee/klee_build/klee/lib
LIB = $(shell find ./lib -name "*.c" -type f)

GTI = -I /usr/include/gtest/
GTL = -L /usr/lib/ 
GTFLAG = -lgtest -lgtest_main -lpthread

TARGET = $(target)

all: $(TARGET)
$(TARGET): ./main_driver_file/$(TARGET).c
	cd lib && $(MAKE)
	$(CC) $(KLEEINC) $(CFLAGS) ./main_driver_file/$(TARGET).c
link: 
	llvm-link -o ${MAIN}c.bc $(LFLAGS) ${MAIN}.bc
	cp ${MAIN}c.bc ./bcfiles/.
	rm ${MAIN}.bc ${MAIN}c.bc

replay:
	$(RPCC) $(RPINC) $(RPLFLAG) $(LIB) ./main_driver_file/$(MAIN).c -lkleeRuntest -lm
gtests:
	${GTCC} ${GTI} ${GTL} -o ${MAIN} $(LIB) ./gtest/${MAIN}.cpp ${GTFLAG}
	cp ${MAIN} ./gtest_exe/.
	rm ${MAIN}

clean:
	find . -name "*.bc" -type f -delete
	rm -f ./bcfiles/*





