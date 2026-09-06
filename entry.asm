.global _start

_start: 
    mov X0, #1
    ldr X1, =hello
    mov X2, #13
    mov X8, #64
    svc 0

    mov X0, #0
    mov X8, #93
    svc 0

.data
hello: .ascii "Hello World!\n"