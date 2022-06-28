       /* 
	loadi   = "00000000";
	mov 	= "00000001";
	add 	= "00000010";
	sub 	= "00000011";
	and 	= "00000100";
	or 	= "00000101";
	j       = "00000110";
	beq	= "00000111";*/


module cpu(PC, INSTRUCTION, CLK, RESET);  //cpu main module with PC as output and INSTRUCTION CLK RESET as input

input [31:0] INSTRUCTION;                 //32bit input port to input the INSTRUCTION
input CLK,RESET;                          //2 input ports to input the CLK and RESET to the cpu
output reg [31:0] PC;                     //1 32bit output port register to store the program counter

reg Write;                                //register to store write enable signal
wire [7:0] aluresult,out1,out2;           //3 8bit wires to output the aluresult out1 and out2
reg select1,select2;                      //2 registers to send selects for two muxes
reg  [2:0] ALUOP;                         //3 bit register to input the ALUOP selections to the alu
wire [7:0] complement,inverse;            //2 8 bit wires to output the complement and the inverse 
reg  [7:0] outmux1,outmux2;               //2 8 bit registers to carry the intermediate outputs from the 1st and 2nd MUXs
reg  [31:0] pc;                           //32bit register to store the pc

always@(posedge CLK)                     //always at the positive clock edge
begin
Write=1;                                 //enable write=1
end

always@(PC)
begin
pc=#1 pc+4;                             //pc is incremented by 4 bytes after a time interval of 1 time units
end

always@(posedge CLK)                    //always at the positive clock edge
begin
if(RESET)                               //when reset is enabled
begin
pc=0;                                   //pc is set to 0
PC = #1 pc;                             //PC is also updated with 0 after a delay of 1 time unit
end
else
PC = #1 pc;                            //else PC is updated with the result in pc after a delay of 1 time unit
end

always@(INSTRUCTION)                   //always
begin
#1;
case(INSTRUCTION[31:24])  //first 8 bits of the INSTRUCTION is considered as the case

            
8'b00000010:begin //ADD selecter for add
     ALUOP= 3'b001; 
      select1=0;
      select2=0;
     end
      
8'b00000011:begin//ADD selecter for sub
	ALUOP= 3'b001;
      	select1=1;
    	select2=0;
	end                
8'b00000100:begin//AND selecter for and
	ALUOP= 3'b010;  
	select1=0;
        select2=0;
	end      
8'b00000101:begin //OR selecter for or
    ALUOP= 3'b011;  
    select1=0;
    select2=0; 
end            
8'b00000001:begin//FORWARD selecter for mov
ALUOP= 3'b000;
select1=0;
select2=0;  //FORWARD selecter for loadi
end  
            
8'b00000000:begin 
ALUOP= 3'b000;
select1=0;
    select2=1;
end
        
             //default is set as the FORWARD selector
endcase
end


reg_file myreg (aluresult, out1,out2,INSTRUCTION [18:16], INSTRUCTION[10:8] , INSTRUCTION[2:0] , Write , CLK , RESET);
//aluresult as IN,out1,out2,WRITEREG as INSTRUCTION[18:16] ,OUT1ADDRESS as INSTRUCTION[10:8],OUT2ADDRESS as INSTRUCTION[2:0],write,clk,reset

assign inverse=~out2;                      //inverse of the operand 2
assign #1 complement=(inverse+8'b00000001);   //complement=inverse+1(2's complement of operand 2)


always@(complement,out2,select1)       //always for mux1
begin
if (select1)       //if the instruction is SUB
     outmux1= complement;                //then send the complement as the output of outmux1
else
     outmux1=out2;                         //else send operand 2
end

always@(outmux1,INSTRUCTION,select2)               //always block for mux2
begin
if (select2)       //if the INSTRUCTION is loadi
     outmux2=INSTRUCTION[7:0];             //then output immediate value
else
    outmux2=outmux1;                       //else output operand 2
end

alu myalu (out1,outmux2,aluresult,ALUOP);  //alu is instantiated as myalu

endmodule
