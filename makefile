# edit this file to build/clean chello as required for quesiton 6

CC=gcc

CFLAGS=-c

all: chello

.PHONY: all main clean

chello: chello.c writeexit.s
	$(CC) $(CFLAGS) chello.c -o chello.o
	as writeexit.s -o writeexit.o
	ld -N chello.o writeexit.o -o chello

clean:
	rm -rf *.o chello
