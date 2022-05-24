/******************************************************************
***Desiged by:		Vedi Ghahremanyans			***
***Topic:		ECE 526 Final Project			***
***Project Name:	Basic Slot Machine			***
***								***
***File Name: 		rgen3.v					***
*******************************************************************
***rgen3 module will take the seed3 generated by the hardware	***			
***and put in the random3 register in order to do logical	***
***operation to create random #3.				***
*******************************************************************/		
`timescale 1 ns / 1 ns

module rgen3(clk, rnum3, seed3);

//**************INPUT/OUTPUT**************
	input clk;
	input [7:0]  seed3;
	output [3:0] rnum3;
//**************INPUT/OUTPUT**************



//**************Register**************
	reg [7:0] random3;
//**************Register**************



//**************Functionality**************
	always @(posedge clk)
		begin
			random3 = seed3;
			random3[0] <= random3[1] ^ random3[5] ^ random3[6] ^ random3[7];
			random3[7:1] <= random3[6:0];
		end

	assign rnum3 = random3[3:0];
//**************Functionality**************

endmodule