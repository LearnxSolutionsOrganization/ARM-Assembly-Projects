@ ARM Assembly - exercise 7 
@ Group Number :04

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	
@int Fibonacci(int n){
@if(n<2){
@return n;}
@else{
@return Fibonacci(n-1)+Fibonacci(n-2)
@}
@}

@ ---------------------	
Fibonacci:

        SUB sp,sp,#12    @adjust stack for three items
        STR lr,[sp,#0]   @save return address which is in lr
        STR r0,[sp,#4]   @save r0 value in stack(argument value)

        CMP r0,#2        @compare n with 2
        BLE ELSE         @if n<=2 go to else
        
        SUB r0,r0,#1     @if n>2 substract n value by 1(n=n-1)
        BL Fibonacci     @nested call for the Fibonacci function
        STR r0,[sp,#8]   @stores Fibonacci(n-1) value in stack pointer
        LDR r0,[sp,#4]   @load the n value to r0

        SUB r0,r0,#2     @substract n value by 2(n=n-2)  
        BL Fibonacci     @second recursive call to the function
        LDR r1,[sp,#8]   @load the value of Fibonacci(n-1) value which is stored in stack to r1 register
        ADD r0,r0,r1     @ add Fibonacci(n-1)+Fibonacci(n-2) value in r0 register to return the value
        LDR lr,[sp,#0]    @restore the return address

        ADD sp,sp,#12    @pop 3 items from the stack 
        MOV pc,lr        @return to caller

ELSE:  
        MOV r0,#1        @if n<=2 fib value is 1.stores it in r0 register to return the value     
        ADD sp,sp,#12    @pop 3 items from the stack
        MOV pc,lr        @return to caller
        
@ ---------------------
	
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the Fibonacci function
	mov r0, r4 	@the arg1 load
	bl Fibonacci
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
format: .asciz "F_%d is %d\n"

