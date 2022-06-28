.text	@ instruction memory

	
	.global main
main:
	@ stack handling
	
	sub	sp, sp, #4     @ allocate stack for lr(link register)
	str	lr, [sp, #0]   @store the return address in sp

	sub	sp, sp, #4     @allocate stack for input(Number of strings)


	@printf for enter the number of strings 
  	ldr	r0, =format1   @load the format string into r0 register 
	bl	printf         @call the printf function @printf("Enter the number of strings:\n")

	@scanf for number of strings 
	ldr	r0, =formats1            @load the format string into r0 register 
	mov	r1, sp                   @put the second argument where we want to store the input from user, into r1 register 
	bl	scanf	                 @scanf("%d",sp)

	
	ldr	r4, [sp,#0]                @copy number of strings from the stack to register r4
	
	
	add	sp, sp, #4              @release the stack which we allocated to take the input
        
	cmp     r4,#0                   @compare r4 register value with 0,r4 register contains the numer of strings                  
	blt     wrong                   @if number of strings less than 0 go to wrong branch to print the error message
	beq     exit                    @if number of strings equal to 0 go to exit branch to exit from the program

	
	mov	r5, #0                  @making r5 register value to 0,counter for the loop               


@loop to take the all the strings from the user

loop:   cmp r5,r4                      @compare r5 register value with r4 (i with numberof strings)
        BGE exit                       @if i>=number of strings exit the program

	sub	sp, sp, #200           @ else allocate space for 200 chars 
	
        @print statement for enter the strings
	ldr    r0,=format2             @load the format string into r0 register 
	mov    r1,r5                   @put the r5(contains the counter i of the loop) into the second argument of printf
	bl	printf                 @printf("\nEnter input string %d:\n",r5)

	
	@scanf for string              
	ldr	r0, =formats3            @load the format string into r0 register to read the multiple words
	mov	r1, sp                   @put the second argument where we want to store the input from user, into r1 register
	bl	scanf	                 @scanf(" %[^\n]s"",sp)  

	@function call 1
	mov	r0, sp                  @put the string into the first argument of strlen function                
	bl	strLen                  @call the strlen function


	mov     r6,r0                   @put the return value of strlen function into r6 register(r0 register contains the return value)  
	sub     r6,r6,#1                @length=length-1

	ldr	r0, =formatp4           @load the format string into r0 register      
	mov     r1,r5                   @put the r5(contains the counter i of the loop) into the second argument of printf
	bl printf                       @printf(Output string %d is...\n",r5)
	

loop2:	mov     r7,sp                   @move the string address(which is in sp) to r7 reg 
	add     r8,r6,r7                @add the r6 with r7 and calculate the address of string character and store it in r8 
	LDRB    r9,[r8,#0]              @load a byte from string to r9 register

        @printf for print the characters

   	ldr	r0, =formatp2           @load the format string into r0 register
	mov     r1,r9                   @put the r9(contains the chracter) into the second argument of printf
	bl printf                       @printf("%c",r9)

        sub     r6,r6,#1               @length=length-1   
        cmp r6,#0                      @compare string length with 0    
	bge     loop2                  @if length greater than or equal iterate the loop
	
        

        add     sp, sp, #200          @release the stack which we allocated for the string
        add     r5,r5,#1              @i=i+1 iterates the loop to take next string
        B loop                        @branch to loop


@prints the statement when negative value is given as the input
wrong: ldr r0,=formatp3              @load the format string into r0 register             
       bl printf                     @printf("Invalid Number\n")
	
   
exit:   ldr	lr, [sp, #0]         @load return address to the link register   
	add	sp, sp, #4           @release stack 
	mov	pc, lr               @return 	


	@ string length function
strLen:
	sub	sp, sp, #4          @ allocate stack for lr(link register)
	str	lr, [sp, #0]        @store the return address in sp

	mov	r1, #0	            @ length counter

loop1:
	ldrb	r2, [r0, #0]        @load a byte(a character) from string to r2 register
	cmp	r2, #0              @compare the character to check whether it is null terminating character or not         
	beq	L2                  @if it is null terminating character go to L2
	add	r1, r1, #1	    @else count length
	add	r0, r0, #1	    @ move to the next element in the char array
	b	loop1               @go to loop1
            
@checks the next char to null terminating character is also a null terminating one
L2:	add	r0, r0, #1          @count length         
        ldrb	r2, [r0, #0]        @load a byte(a character) from string to r2 register
	cmp	r2, #0              @compare the character to check whether it is null terminating character or not           
        beq     end                 @if equal end the loop
        add	r1, r1, #1	    @ else count the length
	add	r0, r0, #1	    @ move to the next element in the char array
	b	loop1               @go to loop1

end:
	mov	r0, r1		    @ return the length to r0
	ldr	lr, [sp, #0]        @load return address to the link register       
	add	sp, sp, #4          @release stack 
	mov	pc, lr              @return 	        




.data	@ data memory
format1: .asciz "Enter the number of strings:\n"
format2: .asciz "\nEnter input string %d:\n"

formats1: .asciz "%d"
formats2: .asciz "\n"
formats3: .asciz " %[^\n]s"

formatp2: .asciz "%c"
formatp3: .asciz "Invalid Number\n"
formatp4: .asciz "Output string %d is...\n"
