CC=gcc

CFLAGS=-c

all: chello

.PHONY: all clean

chello.o: chello.c
	$(CC) $(CFLAGS) $^ -o chello.o

writeexit.o: writeexit.s
	as $^ -o writeexit.o

chello: chello.o writeexit.o
	ld -N $^ -o chello

clean:
	rm -rf *.o chello
