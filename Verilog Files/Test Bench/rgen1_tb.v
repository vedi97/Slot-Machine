/******************************************************************
***Desiged by:		Vedi Ghahremanyans			***
***Topic:		ECE 526 Final Project			***
***Project Name:	Basic Slot Machine			***
***								***
***File Name: 		rgen1_tb.v				***
*******************************************************************
***regn1_tb module tests the functionality of rgen1 module 	***		
***which will take different random seeds and generate random 	***
***numers, rnum1.						***
*******************************************************************/	
`timescale 1 ns / 1 ns

module rgen1_tb();

//**************Register**************
	reg	[5:0]seed1;
	reg 	clk;
	wire	[3:0]rnum1;
//**************Register**************



//**************Instantiation of rgen1 module**************
rgen1	re1(.clk(clk), .seed1(seed1), .rnum1(rnum1));
//**************Instantiation of rgen1 module**************



//**************Clock Generator for period=10**************
	initial
		begin
			clk = 0;
			forever
			#5 clk = ~clk;
		end
//**************Clock Generator for period=10**************



//**************Monitor**************
	initial 
		begin
			$monitor("%d:   clk=%b, seed1=%d ........ rnum1=%d", $time, clk, seed1, rnum1);
		end
//**************Monitor**************


//**************Test Cases**************
	initial
		begin
		$vcdpluson;
		$display("\n");

		#5	seed1 = 5'd25;
		#10 	seed1 = 5'd13;
		#10	seed1 = 5'd42;
		#10	seed1 = 5'd56;
		#10	seed1 = 5'd23;
		#10	seed1 = 5'd102;
		#10	seed1 = 5'd33;
		#10	seed1 = 5'd12;
		#10	seed1 = 5'd4;
		#10	seed1 = 5'd650;
		#10	seed1 = 5'd120;
		#10	seed1 = 5'd12;
		
		#10 $finish;
		end
//**************Test Cases**************


endmodule
