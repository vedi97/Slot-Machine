/******************************************************************
***Desiged by:		Vedi Ghahremanyans			***
***Topic:		ECE 526 Final Project			***
***Project Name:	Basic Slot Machine			***
***								***
***File Name: 		RandomNumberHandler_tb.v		***
*******************************************************************
***This module tests functionality of the RandomNumberHandler.	***		
***By generating 10ns clock period with input seeds, random 	***
***numbers will be created and based on those random numbers	***
***and the result of bet_1d and bet_2d winner or loser will be	***
***determined.							***
***		   -------------------------------		***
***			bet_1d     |    bet_2d      		***
***		   -------------------------------		***
***	 	    WIN  |  LOSE   | WIN  |  LOSE  		***
***		   -------------------------------		***
***		    0    |    1    |  2   |    3   		***
*******************************************************************/
`timescale 1 ns / 1 ns

module RandomNumberHandler_tb();

//**************Register**************
	reg	clk;
	reg	[5:0] seed1;
	reg	[6:0] seed2;
	reg	[7:0] seed3;
	wire	[3:0] rnum1;
	wire	[3:0] rnum2;
	wire	[3:0] rnum3;
	wire 	[1:0] bet_1d, bet_2d;
//**************Register**************



//**************Instantiation of RandomNumberHandler module**************
RandomNumberHandler	Test1(.clk(clk), .rnum1(rnum1), .rnum2(rnum2), .rnum3(rnum3), .seed1(seed1), .seed2(seed2), .seed3(seed3), .bet_1d(bet_1d), .bet_2d(bet_2d));
//**************Instantiation of RandomNumberHandler module**************



//**************Clock Generator for period=10**************
	initial 
		begin
		clk = 0;
		forever #5 clk = ~clk;
		end
//**************Clock Generator for period=10**************



//**************Monitor**************
	initial
		begin
		$monitor("%d: clk=%b....seed1=%b, seed2=%b, seed3=%b----rnum1=%d, rnum2=%d, rnum3=%d...|...bet_1d=%d   bet_2d=%d",$time, clk, seed1, seed2, seed3, rnum1, rnum2, rnum3, bet_1d, bet_2d);
		end
//**************Monitor**************



//**************Test Cases**************
	initial 
	begin
	$vcdpluson;
	$display ("\n************************************");
	$display ("    bet_1d     |   bet_2d      ");
	$display ("-------------------------------");
	$display ("WIN  |  LOSE   | WIN  |  LOSE  ");
	$display ("-------------------------------");
	$display ("0    |     1   |  2   |    3   ");
	$display ("************************************\n");

	//******TEST CASE#1******
	#10
	$display ("\n");	
	seed1 = 5'd1;
	seed2 = 6'd1;
	seed3 = 7'd5;
	
	//******TEST CASE#2******
	#10
	$display ("\n");
	seed1 = 5'd10;
	seed2 = 6'd14;
	seed3 = 7'd20;

	//******TEST CASE#3******
	#10
	$display ("\n");
	seed1 = 5'd4;
	seed2 = 6'd25;
	seed3 = 7'd2;

	//******TEST CASE#4******
	#10
	$display ("\n");
	seed1 = 5'd45;
	seed2 = 6'd6;
	seed3 = 7'd23;

	//******TEST CASE#5******
	#10
	$display ("\n");
	seed1 = 5'd12;
	seed2 = 6'd33;
	seed3 = 7'd5;

	//******TEST CASE#6******
	#10
	$display ("\n");
	seed1 = 5'd3;
	seed2 = 6'd6;
	seed3 = 7'd90;

	//******TEST CASE#7******
	#10
	$display ("\n");
	seed1 = 5'd5;
	seed2 = 6'd5;
	seed3 = 7'd5;

	//******TEST CASE#8******
	#10
	$display ("\n");
	seed1 = 5'd34;
	seed2 = 6'd21;
	seed3 = 7'd22;

	//******TEST CASE#9******
	#10
	$display ("\n");
	seed1 = 5'd56;
	seed2 = 6'd33;
	seed3 = 7'd90;

	//******TEST CASE#10******
	#10
	$display ("\n");
	seed1 = 5'd3;
	seed2 = 6'd3;
	seed3 = 7'd4;

	//******TEST CASE#11******
	#10
	$display ("\n");
	seed1 = 5'd120;
	seed2 = 6'd12;
	seed3 = 7'd45;

	//******TEST CASE#12******
	#10
	$display ("\n");
	seed1 = 5'd1;
	seed2 = 6'd1;
	seed3 = 7'd1;

	//******TEST CASE#13******
	#10
	$display ("\n");
	seed1 = 5'd201;
	seed2 = 6'd12;
	seed3 = 7'd43;

	#10 	$display ("\n");
		$finish;
	end
//**************Test Cases**************

endmodule
