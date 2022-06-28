@ ARM Assembly - exercise 5
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
	
	@ j=0;
	@ for (i=0;i<10;i++)
	@ 		j+=i;	
	
	@ Put final j to r5

	@ ---------------------
        MOV r5,#0@ assign j value to  0
	MOV r4,#0@ assign i value to  0
	loop:CMP r4,#10 @ compare i value(stored in r4 register)with 10
             BGE EXIT @ if i>=10 exit loop
             ADD r5,r5,r4 @if i<10 add j and i,store the result in r5 register;
	     ADD r4,r4,#1 @increments the i value i=i+1
             B loop @ go to loop(iterates the loop)
      
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
format: .asciz "The Answer is %d (Expect 45 if correct)\n"

