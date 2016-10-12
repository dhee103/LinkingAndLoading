
        .text
        .globl _start
_start:
        movl   $0x4, %eax       # eax = code for 'write' system call
        movl   $1, %ebx         # ebx = file descriptor to standard output
        movl   $message, %ecx   # ecx = pointer to the message
        movl   $13, %edx        # edx = length of the message
        int    $0x80            # make the system call
        movl   $0x0, %ebx       # the status returned by 'exit'
        movl   $0x1, %eax       # eax = code for 'exit' system call
        int    $0x80            # make the system call
        .data
        .globl message
message:
        .string "Hello world!\n" # The message as data
