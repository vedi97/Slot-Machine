/******************************************************************
***Desiged by:		Vedi Ghahremanyans			***
***Topic:		ECE 526 Final Project			***
***Project Name:	Basic Slot Machine			***
***								***
***File Name: 		slot_machine.v				***
*******************************************************************
***In the slot_machine module, it is the top level module 	***		
***which instantiates the RandomNumberHandler module. 		***
***This machine works with clock and two Enables and a current	***
***state0. Inputs are as followed: 				***
***								***
***--------------------------INPUT------------------------------***
***CLOCK:	Clock is generated each 10ns perios.		***
***								***
***COLLECT: 	Collect input is for collecting the fund either ***
***		the users credit is finished or not.		***
***								***
***BET:		Bet input is the bet for $1 or $2 for the slot 	***
***		machine.					***
***								***
***SEED:	For the purposes of this class project, the 	***
***		three seeds, seed1, seed2, and seed3 will be 	***
***		inputed manually in the test bench, however, 	***
***		later on the goal is to genrete random seeds 	***
***		using the clock.				***
***								***
***CREDIT:	Credit is the amont of money the user will 	***
***		insert in the slot machine to start the game.   ***
***		(MIN of $2 is needed to start the game.)	***
***								***
***--------------------------OUTPUT-----------------------------***
***BET_1D:	This output comes from the Random number 	***
***		Handler which shows if $1 was bet.		***
***								***
***BET_2D:	This output is same as BET_1D and shows if 	***
***		$2 was bet.					***
***								***
***FUND:	Fund output holds the amont of credit was added ***
***		by the user and in case of "collect" input 	***
***		it gives out the amont to the user.		***
***								***
***RNUM:	rnum1, rnum2, and rnum3 are generated based on	***
***		the seeds given and are being generated in the 	***
***		module rgen1, rgen2, and rgen3. 		***
***		They are three random numbers and are used to 	***
***		decide if the user is winner or not. 		***
***								***
***-------------------------REGISTERS---------------------------***
***FUND_REG:	fund_reg is a register which holds the value of ***
***		FUND and does addition or subtraction and once 	***
***		collect input is triggered it gives it's value	***
***		to the FUND output in order for the user to 	***
***		collect their money.				***
***								***
***ENA_BET:	ENA_bet will work when clock is high and if 	***
***		there has been a bet of $1 or $2 placed. 	***
***		In that condition, the ENA_bet will go high for	***
***		2ns and comes to low again. In that 2ns the game***
***		will begin and user will either win or lose. 	***
***								***
***ENA_CREDIT:	ENA_credit is used to let credit to be inserted ***
***		into the fund and finaly into the fund_reg. 	***
***		In case of a change of credit the ENA_bet	***
***		will go high for 2ns and will go low after. 	***
***		during that 2ns period Credit will go to 	***
***		fund and eventually to fund_reg to do the sum or***
***		subtraction.(During the ENA_Credit the ENA_BET	***
***		is "X" so no game will play during that		***
***		transcation.)					***
*******************************************************************/	
`timescale 1 ns / 1 ns

module slot_machine(fund, rnum1, rnum2, rnum3, bet_1d, bet_2d, bet, credit, collect, clock, seed1, seed2, seed3);
	
//**************Parameters**************
parameter [1:0]one_d		= 2'b01;	//$1
parameter [1:0]two_d		= 2'b10;	//$2
parameter [1:0]one_d_win	= 2'b00;	//$1 WIN
parameter [1:0]one_d_lose	= 2'b01;	//$1 LOSE
parameter [1:0]two_d_win 	= 2'b10;	//$2 WIN
parameter [1:0]two_d_lose	= 2'b11;	//$2 LOSE
//**************Parameters**************



//*************Inputs and Outputs*************
	input	clock;
	input	collect;	//When collect bottom is pushed whatever the fund is the user will collect.	
	input	[1:0] bet; 	//User has two options of input, bet one_d($1) or bet two_d($2)		
	input	[5:0] seed1;	//For purposes of this project all the seeds will be given manualy in the test bench
	input	[6:0] seed2;	
	input	[7:0] seed3;
	input	[9:0] credit;	//Credit is the amont of money user will need to insert to begin to play 

	output	[1:0] bet_1d, bet_2d;		//bet_1d and bet_2d are the output register which hold the status of $1 or $2 
	output	[9:0] fund; 			//Output fund will be the fund that the user will collect later
	output 	[3:0] rnum1, rnum2, rnum3; 	//Random Numbers
//*************Inputs and Outputs*************

//**************Registers/Wires**************
	reg	[9:0] fund_reg;			//Fund_register is created in order to do all boolean algebra 
	reg	[9:0] fund;
	reg 	[1:0] state0; 
	reg 	[1:0] bet_1d, bet_2d;
	reg	ENA_bet;		//ENA_bet is a register which will let the game begin after the bet
	reg 	ENA_credit;		//ENA_credit is a register which when it changes its value it will allow the credit 	
					//to be inserted into the fund register
	wire	collect;
//**************Registers/Wires**************		



//*********************INSTANCES*********************
RandomNumberHandler	RNH(.clk(clock), .rnum1(rnum1), .rnum2(rnum2), .rnum3(rnum3), .seed1(seed1), .seed2(seed2), .seed3(seed3), .bet_1d(bet_1d), .bet_2d(bet_2d));
//*********************INSTANCES*********************



//**************ENABLE Credit Transfer**************	
		always @(credit)				//Whenever there is a change in credit, user won't be able to bet
			begin					//,even if they bet the game will not play, then ENA_credit will
			ENA_bet = 1'bx;				//be enable for 2ns and the credit will be transfered into the fund and 
			ENA_credit = 1'b1;			//eventually into the fund register.
			#2 ENA_credit = 1'b0;
			end
//**************ENABLE Credit Transfer**************	



//**************Credit Transfer to Fund**************	
		always @(ENA_credit == 1'b1)		//This part will transfer the credit into fund for the game to begin 
			begin				//when ENA is high.  However, whenever the ENA is not high, fund will  
			fund = credit;			//not have anything transfer to it.
			fund_reg = fund;
			end
//**************Credit Transfer to Fund**************	



//**************ENABLE BET**************
		always @(posedge clock)				//This part of the code will make high enable whenever 
			begin					//there is a one or two dollor bet and by making the 
				if (bet == one_d | two_d)	//ENA_bet high the game will actually start add or  
				begin				//subtract the inserted credit fund. 
				ENA_bet = 1'b1;
				#2 ENA_bet = 1'b0;
				end
			end
//**************ENABLE BET**************






//*****************************************Functionality*****************************************
	always @(posedge ENA_bet) 
		begin
		state0 = bet;
			if(fund_reg >= 10'd2)				//Minimum of $2 is needed to bet				
			begin	
			$display ("\n*************************");
			$display ("Available Credit:$%d ",credit);	
			$display ("Bet $1 or $2 and WIN");
			$display ("*************************");

		
			case (state0)
				one_d:	//$1 bet
				begin
					if( bet_1d === one_d_win )	//Bet_1d was taken from the RandomNumberHandler module
					begin				//which if it is equal to the one_d_win condition then the user wins $1
						//WIN $1
						fund_reg = fund_reg + 10'd1;
					end
		
					else if( bet_1d === one_d_lose )//which if it is equal to the one_d_lose condition then the user loses $1
					begin
						//LOSE $1
						fund_reg = fund_reg - 10'd1;
					end

				end
				
				
				two_d:	//$2 bet
				begin
	
					if ( bet_2d === two_d_win )	//Bet_2d was taken from the RandomNumberHandler module
					begin				//which if it is equal to two_d_win condition then the user wins $2
						//WIN $2
						fund_reg = fund_reg + 10'd2;
					end

					else if ( bet_2d === two_d_lose )//which if it is equal to two_d_lose condition then the user loses $2	
					begin	
						//LOSE $2
						fund_reg = fund_reg - 10'd2;
					end
					
				defualt: state0 = bet;			//In case of a bet of $3 or $4 or if the bet becomes "x" or "z" system won't 
				end					//be doing anything to the fund. 
				endcase
			end	
			

			else 		//If min $2 is not inserted, hardware will display the following error
			begin
				$display ("\n*************************");				
				$display ("Not enough Credit: %d", credit);	
				$display ("Min Credit to start: $2");
				$display ("*************************\n");
			end
		end
//*****************************************Functionality*****************************************
	


//****************COLLECT*********************
		always @(collect)
			begin
				fund = fund_reg; 
				fund_reg = 0;
			end
//****************COLLECT*********************

endmodule
