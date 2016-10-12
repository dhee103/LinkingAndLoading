# edit this file to build/clean chello as required for quesiton 6

CC=gcc

CFLAGS=-c -Wall -Werror -pedantic -std=c99

all: main

.PHONY: all main clean

main: chello.c writeexit.s
	$(CC) -c chello.c -o chello.o
	as writeexit.s -o writeexit.o
	ld -N chello.o writeexit.o -o chello

clean:
	rm -rf *.o
	rm -rf chello
