@ ARM Assembly - lab 3.1
@ 
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	

@int mypow=1
@for(int i=0;i<n:i++){
@mypow=mypow*X
@}

mypow:

	mov r7,#0      @i=0
        mov r8,#1      @ mypow=1

loop:	CMP r7,r1     @compare i with n
	BGE exit      @if i>=n exit loop
        mov r9,r8     @r9=r8
	mul r8,r9,r0  @ mypow=mypow*x
        add r7,r7,#1  @i=i+1
        b loop        @go to loop
exit:   
        mov r0,r8     @store return value in r0
        mov pc,lr     @return address

@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value x
	mov r5, #3 	@the value n
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl mypow
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "%d^%d is %d\n"

