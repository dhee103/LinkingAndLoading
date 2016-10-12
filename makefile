CC=gcc

CFLAGS=-c

all: chello

.PHONY: all clean

chello.o: chello.c
	$(CC) $(CFLAGS) $^ -o $@

writeexit.o: writeexit.s
	as $^ -o $@

chello: chello.o writeexit.o
	ld -N $^ -o $@

clean:
	rm -rf *.o chello
