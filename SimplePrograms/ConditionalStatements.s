@ ARM Assembly - lab 2
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
	
	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);	
	@			}	
	@	} 
	@ Put final sum to r5


	@ ---------------------
        MOV r5,#0 @assigning sum=0
	MOV r4,#0 @assigning i value(stored in r4 register) to 0
       
	loop1:CMP r4,#10 @compares i value with 10(immediate operand)
	      MOV r6,#5 @assigning j value to 5
              BLT loop2 @ if i<10 go to loop2 code segment
              B EXIT @else Exit the loop1
       
        loop2:
              CMP r6,#15 @compares j value with 15(immediate operand)
              BLT IF      @if j<15 go to if condition
              ADD r4,r4,#1 @else increments the i value(i=i+1)and store it in r4 register
              B loop1 @go to loop1(iterates the loop)

        IF:ADD r7,r4,r6 @ add i and j values and store it in r7 register
	   CMP r7,#10 @ compare (i+j) value with 10
	   BGE ELSE  @if (i+j)>=10 go to ELSE code segment
           ADD r5,r5,r4,LSL #1 @else add i multiplied by 2 value to the sum and store it in r5 register
	   ADD r6,r6,#1@increments the j value(j=j+1)
           B loop2 @ go to loop2(iterates the loop2)
           
           
        ELSE:AND r8,r4,r6 @ do the AND operation to i and j,then stores it in r8 register
             ADD r5,r5,r8 @add (i&j) value to the sum and store it in r5 register
             ADD r6,r6,#1 @increments the j value(j=j+1)
             B loop2 @ go to loop2(iterates the loop2)
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
format: .asciz "The Answer is %d (Expect 300 if correct)\n"

