@ ARM Assembly - lab 3.2 
@ Group Number :04

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
gcd:
      SUB sp,sp,#4     @Adjust stack for return address
      STR lr,[sp,#0]   @save return address
      cmp r1,#0        @ compare b with 0
      BEQ Exit         @if b=0 go to exit 

loop: cmp r0,r1        @compare a and b value  
      BLT IF           @if a<b go to IF
      SUB r0,r0,r1     @else a=a-b
      B loop           @ go to loop
      
IF:  MOV r7,r0         @store a%b value in r7 register
     MOV r0,r1         @a=b
     MOV r1,r7         @b=a%b(remainder)
     BL gcd            @nested call to function gcd
     LDR lr,[sp,#0]    @restore return address   
     
Exit:
     
     ADD sp,sp,#4      @pop 1 item from stack
     MOV pc,lr         @returnto caller

@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #64	@the value a
	mov r5, #24	@the value b
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
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
format: .asciz "gcd(%d,%d) = %d\n"

