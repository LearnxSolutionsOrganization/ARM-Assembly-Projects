@ ARM Assembly - exercise 3 
@ Group Number :

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	mov r0, #10
	mov r1, #5
	mov r2, #7
	mov r3, #-8

	
	@ Write YOUR CODE HERE
	@ a,b,i,j in r0,r1,r2,r3 respectively
	@	if (i>=j) f = a+b;
	@	else f = a-b;
	@ Use signed comparison
	@ Put f to r5

	@ ---------------------
	CMP r2,r3 @compare i value(stored in r2) with j value(stored in r3 register)
        BLT ELSE @go to ELSE if i<j

        ADD r5,r0,r1 @if i>=j add a and b values and store it in r5 register 
	B EXIT @ go to exit

	ELSE:
		SUB r5,r0,r1@ if i<j substract b from a value and store it in r5 register
	EXIT: 

	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 15 if correct)\n"

