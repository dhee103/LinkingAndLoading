# edit this file to build/clean chello as required for quesiton 6

CC=gcc

CFLAGS=-c

all: chello

.PHONY: all main clean

chello: chello.o writeexit.o
	ld -N chello.o writeexit.o -o chello

writeexit.o: writeexit.s
	as writeexit.s -o writeexit.o

chello.o: chello.c
	$(CC) $(CFLAGS) chello.c -o chello.o

clean:
	rm -rf *.o chello
