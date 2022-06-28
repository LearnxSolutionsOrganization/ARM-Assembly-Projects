module testbench;               // Module to test the reg_file module

reg [7:0] IN ;                  // 8 bit register to input Data
wire [7:0] OUT1,OUT2;           //two 8 bit wires to output the data
reg  [2:0] INADDRESS,OUT1ADDRESS,OUT2ADDRESS ;//3 3bit register to input-address data
reg WRITE,CLK,RESET;                //3 registers to input the write,clk and reset datas

reg_file R1(IN, OUT1 , OUT2, INADDRESS, OUT1ADDRESS , OUT2ADDRESS , WRITE , CLK , RESET );//Instantiating ALU module as R1

initial

begin
//monitoring the inputs and outputs
$monitor($time,"  IN=%b, OUT1=%b , OUT2=%b, INADDRESS=%b, OUT1ADDRESS=%b , OUT2ADDRESS=%b , WRITE=%b , CLK=%b , RESET=%b\n",IN, OUT1 , OUT2, INADDRESS, OUT1ADDRESS , OUT2ADDRESS , WRITE , CLK , RESET);


// at 5 time units IN and INADDRESS is given,WRITE enabled,CLK=1
#5
IN=8'b00000110;
INADDRESS=3'b010;
CLK=1'b1;
WRITE=1'b1;
RESET=1'b0;
//at 10 time units OUT1ADDRESS is given and OUT1 is displayed after 2 time units of delay

#5
OUT1ADDRESS=3'b010;
CLK=1'b0;
WRITE=1'b0;

// at 15 time units IN and INADDRESS is given,WRITE enabled,CLK=1
#5
IN=8'b11100110;
INADDRESS=3'b011;
CLK=1'b1;
WRITE=1'b1;

//at 20 time units OUT2ADDRESS is given and OUT2 is displayed after 2 time units of delay

#5
OUT2ADDRESS=3'b011;
CLK=1'b0;
WRITE=1'b0;

//at time 25 RESET is enabled
 #5
RESET=1;
CLK=1;



end

initial
begin
$dumpfile("wavedataregfile.vcd");
$dumpvars(0,R1);


end
endmodule


module reg_file (IN, OUT1 , OUT2, INADDRESS, OUT1ADDRESS , OUT2ADDRESS , WRITE , CLK , RESET ); //Module for a REGISTER file

input [7:0] IN ;                                //8bit input port to get the input data
output [7:0] OUT1,OUT2;                         //2 8bit output ports to output the data
input  [2:0] INADDRESS,OUT1ADDRESS,OUT2ADDRESS ;//3 3bit input ports to input-address data
input WRITE,CLK,RESET;                          //3 input ports to get the write,clk and reset datas

reg [7:0] store [7:0] ;                         //8 8bit registers to store data


assign #2 OUT1= store[OUT1ADDRESS];   //after a time delay of two time units data in out1address register is read into the OUT1 port
assign #2 OUT2= store[OUT2ADDRESS];   //after a time delay of two time units data in out2address register is read into the OUT2 port

always @ (posedge  CLK ) //Always at a rising edge of  a clock the following code block is executed
 begin
 if (WRITE)             //when write is enabaled
 	begin
	      store[INADDRESS] <= #1 IN;  //fetch the data to the IN input and after a time delay of 1 time unit it is stored at the address of INADDRESS of the store register
	end


 if(RESET)           //if reset is enabled all the 8bit registers are set with zero
	begin 
	      store[0]<=   #1 8'b00000000;
	      store[1]<=  #1  8'b00000000;
	      store[2]<=  #1  8'b00000000;
              store[3]<= #1   8'b00000000;
	      store[4]<=  #1  8'b00000000;
	      store[5]<=  #1  8'b00000000;
	      store[6]<=  #1  8'b00000000;
	      store[7]<=  #1  8'b00000000;
	end
end
endmodule













	
