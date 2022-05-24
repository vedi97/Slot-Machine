/******************************************************************
***Desiged by:		Vedi Ghahremanyans			                      ***			
***Topic:		ECE 526 Final Project			                          ***
***Project Name:	Basic Slot Machine			                      ***
***								                                              ***
***File Name: 		rgen2.v					                              ***		
*******************************************************************
***rgen2 module will take the seed2 generated by the hardware	  ***			
***and put in the random2 register in order to do logical	      ***
***operation to create random #2.			                        	***				
*******************************************************************/		
`timescale 1 ns / 1 ns

module rgen2(clk, rnum2, seed2);

//**************INPUT/OUTPUT**************
	input  clk;
	input  [6:0] seed2;
	output [3:0] rnum2;
//**************INPUT/OUTPUT**************



//**************Register**************
	reg [6:0] random2;
//**************Register**************



//**************Functionality**************
	always @(posedge clk)
		begin
			random2 = seed2;
			random2[0] <= random2[5] ^ random2[6];
			random2[6:1] <= random2[5:0];
		end

	assign rnum2 = random2[3:0];
//**************Functionality**************


endmodule

