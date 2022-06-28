@ ARM Assembly - exercise 6 
@ Group Number :04

	.text 	@ instruction memory
	
	
@ Write YOUR CODE HERE	

@ ---------------------	
@int f=1;
@for (int i=2;i<=n;i++){
		@f=f*i;}

fact:
	mov r6,#2   @i=2
	mov r7,#1   @defining a variable to store factorial value
	
loop:
	cmp r6,r0          @Compare i with n
	BGT exit           @if i>n go to else
	mov r8,r7          @store r7 value in r8 register(r8=r7)
	mul r7,r8,r6       @multiply i with current factorial value and store it in r7(r7=r8*r6)
	ADD r6,r6,#1       @i=i+1
	B loop             @go to loop
	
exit:
        mov r0,r7          @return final value into r0 register
	mov pc,lr          @return address

@ ---------------------	

.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the fact function
	mov r0, r4 	@the arg1 load
	bl fact
	mov r5,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "Factorial of %d is %d\n"

