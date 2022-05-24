# Slot-Machine
Basic Slot machine designed with Verilog HDL
---------------------------------------------
A basic, and user friendly slot machine was designed which would intake only one dollar, and
two dollar bets. The minimum input credit that the machine requires in order to start the game is
$2. The slot machine works with a clock, and a register which enables the bet. 

Followings are the inputs, outputs and registers created for this machine: 


***Inputs**

● Clock

● Collect: This input is to collect the fund either when the input credit is finished or not.

● Bet    : Bet input is the bet for $1 or $2. One_d = 01 = $1, two_d = 10 = $2.

● Seed   : Seed is the initial number given by myself in order to start generating the random numbers.

● Credit : Credit is the amount of money the user inserts in order for the game to start (Minimum of $2 is needed for the game to start)


***Outputs**

● Bet_1d: bet_1d is the output from the RNH which shows that $1 was bet by the user.

● Bet_2d: bet_2d is the output from the RNH which shows that $2 was bet by the user.

● Fund  : Fund output holds the amount of credit that was added by the user and in case of a “collect” input, this amount is collected collected by the user.

● Rnum  : Rnum1, rnum2, and rnum3 are generated in the modules rgen1, rgen2, and rgen3 based on the input seeds. They are three random numbers that are used to choose           if the user is winner or not. 


***Registers**

● Fund_reg: Fund register is a register which holds the value of the output fund and does addition or subtraction to it and once collect input is triggered, fund                     register gives it’s value to the fund output in order for the user to collect their money.

● ENA_bet : On positive edge of the clock if a bet of $1 or $2 has been placed then the ENA_bet will go high for 2ns to let the game begin and then will become zero                 again. In that 2ns while the game is in place there will be a winner or a loser.

● ENA_credit: When the credit input is triggered the ENA_credit will go high for 2ns and it will let the credit’s value to transfer to fund output and the fund                       register (During the ENA_credit the ENA_bet is “X” so no game will be played during that transaction). 

