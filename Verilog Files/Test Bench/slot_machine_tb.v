/******************************************************************
***Desiged by:		Vedi Ghahremanyans			***
***Topic:		ECE 526 Final Project			***
***Project Name:	Basic Slot Machine			***
***								***
***File Name: 		slot_machine_tb.v			***
*******************************************************************
***Slot_machine_tb module tests different cases of the users 	***			
***inputing the collect, credit, and bet inputs. 		***
***Different test cases has been tested with a 10ns clk period. ***
*******************************************************************/	
`timescale 1 ns / 1 ns

module slot_machine_tb();

//****************Parameters****************
parameter [1:0]one_d	= 2'b01;
parameter [1:0]two_d	= 2'b10;
//****************Parameters****************

//**************Registers/Wires**************
	reg 	collect, clock;
	reg 	[1:0] bet;
	reg	[5:0] seed1;
	reg	[6:0] seed2;
	reg	[7:0] seed3;
	reg	[9:0] credit;

	wire	[1:0] bet_1d, bet_2d;
	wire	[9:0] fund, fund_reg;
	wire	[3:0] rnum1, rnum2, rnum3; 
//**************Registers/Wires**************


//*********************INSTANCES*********************
slot_machine  sm(.fund(fund), .collect(collect), .clock(clock), .bet(bet), .seed1(seed1), .seed2(seed2), .seed3(seed3), .credit(credit), 
		 .bet_1d(bet_1d), .bet_2d(bet_2d), .rnum1(rnum1), .rnum2(rnum2), .rnum3(rnum3));
//*********************INSTANCES*********************


//**************Clock Generator for period=10**************
	initial 
		begin
		clock = 0;
		forever #5 clock = ~clock;
		end
//**************Clock Generator for period=10**************



//**************Test Cases**************
	initial
	begin
	$vcdpluson;
	
	//******INITIALIZATION******
	#5
	collect	=0;
	credit 	=0;

	//******$4 Credit Inserted******
	#10
	credit 	=10'd4;
	seed1	=5'd1;
	seed2	=6'd1;
	seed3	=7'd5;

	//******Bet $2******
	#10
	bet	=two_d;

	//******Bet $2******
	#10
	seed1	=5'd45;
	seed2	=6'd3;
	seed3	=7'd1;
	bet	=two_d;

	//******Bet $1******
	#10
	seed1	=5'd11;
	seed2	=6'd3;
	seed3	=7'd2;
	bet	=one_d;

	//******Bet $1******
	#10
	seed1	=5'd23;
	seed2	=6'd100;
	seed3	=7'd29;
	bet	=one_d;

	//******Bet $1******
	#10
	seed1	=5'd4;
	seed2	=6'd4;
	seed3	=7'd4;
	bet	=one_d;

	//******Bet $2******
	#10
	seed1	=5'd1;
	seed2	=6'd2;
	seed3	=7'd3;
	bet	=two_d;

	//******Bet $2******
	#10
	seed1	=5'd33;
	seed2	=6'd5;
	seed3	=7'd6;
	bet	=two_d;

	//******Bet $1******
	#10
	seed1	=5'd23;
	seed2	=6'd1;
	seed3	=7'd4;
	bet	=one_d;

	//******Bet $1******
	#10
	seed1	=5'd1;
	seed2	=6'd1;
	seed3	=7'd1;
	bet	=one_d;

	//******$50 Credit Inserted******
	#10
	credit	=10'd50;

	//******Bet $2******
	#10
	seed1	=5'd68;
	seed2	=6'd1;
	seed3	=7'd1;
	bet	=two_d;

	//******Bet $2******
	#10
	seed1	=5'd40;
	seed2	=6'd22;
	seed3	=7'd1;
	bet	=two_d;

	//******Bet $2******
	#10
	seed1	=5'd68;
	seed2	=6'd4;
	seed3	=7'd20;
	bet	=two_d;

	//******Bet $1******
	#10
	seed1	=5'd37;
	seed2	=6'd37;
	seed3	=7'd37;
	bet	=one_d;

	//******Bet $2******
	#10
	seed1	=5'd69;
	seed2	=6'd420;
	seed3	=7'd1000;
	bet	=two_d;

	//******Bet $2******
	#10
	seed1	=5'd32;
	seed2	=6'd44;
	seed3	=7'd32;
	bet	=two_d;

	//******Bet $2******
	#10
	seed1	=5'd5;
	seed2	=6'd5;
	seed3	=7'd5;
	bet	=two_d;

	//******Collect******
	#10
	collect = 1'b1;

	//**********************Second User**********************
	#30
	collect = 0;

	//******$10 Credit Inserted******
	#10
	credit = 10'd10;

	//******Bet $2******
	#10
	seed1	=5'd1;
	seed2	=6'd45;
	seed3	=7'd0;
	bet	=two_d;

	//******Bet $2******
	#10
	seed1	=5'd1;
	seed2	=6'd3;
	seed3	=7'd4;
	bet	=two_d;

	//******Bet $2******
	#10
	seed1	=5'd54;
	seed2	=6'd6;
	seed3	=7'd4;
	bet	=two_d;

	//******Bet $2******
	#10
	seed1	=5'd0;
	seed2	=6'd0;
	seed3	=7'd0;
	bet	=two_d;

	//******Bet $1******
	#10
	seed1	=5'd2;
	seed2	=6'd44;
	seed3	=7'd34;
	bet	=one_d;

	//******Bet $1******
	#10
	seed1	=5'd1;
	seed2	=6'd45;
	seed3	=7'd0;
	bet	=one_d;

	//******Bet $2******
	#10
	seed1	=5'd20;
	seed2	=6'd100;
	seed3	=7'd12;
	bet	=two_d;

	//******Collect******
	#10
	collect = 1'b1;


	#20	$finish;
	end
//**************Test Cases**************

endmodule
