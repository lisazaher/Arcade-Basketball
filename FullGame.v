module FullGame (VGA_CLK,   						//	VGA Clock
	VGA_HS,							//	VGA H_SYNC
	VGA_VS,							//	VGA V_SYNC
	VGA_BLANK_N,						//	VGA BLANK
	VGA_SYNC_N,						//	VGA SYNC
	VGA_R,   						//	VGA Red[9:0]
	VGA_G,	 						//	VGA Green[9:0]
	VGA_B,   						//	VGA Blue[9:0]
	CLOCK_50,
	KEY,
	PS2_CLK,
	PS2_DAT,
	SW, LEDR,
	HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,
	GPIO_1, GPIO_0
	);
	
	inout				PS2_CLK;
	inout				PS2_DAT;


	input CLOCK_50;
	input [3:0] KEY;
	input [9:0] SW;
	input [35:0]GPIO_1;
	output [35:0]GPIO_0;
	output [1:0] LEDR;
	output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire [7:0]X;
	wire [6:0]Y;
	wire [5:0] letter1, letter2, letter3, letter4, letter5;
	wire [2:0]CLR;
	wire [3:0]timeOne, timeTen, scoreOne, scoreTen, highOne, highTen;
	wire PLOT,go, countFlag;
	
	
	assign GPIO_0[0] = countFlag;
	assign GPIO_0[1] = countFlag;
	assign LEDR[0] = countFlag;
	assign LEDR[1] = GPIO_1[1];
	
	PS2 kb(.CLOCK_50(CLOCK_50),
			.KEY(KEY),
			.PS2_CLK(PS2_CLK),
			.PS2_DAT(PS2_DAT),
			.doneentry(go),
			.symbol1(letter1), 
			.symbol2(letter2), 
			.symbol3(letter3), 
			.symbol4(letter4), 
			.symbol5(letter5)
);

	
	game g(.clk(CLOCK_50), 
		  .go(go), 
		  .reset(KEY[0]), 
		  .inputOne(~GPIO_1[1]), 
		  .saveDone(SW[0]), 
		  .countFlag(countFlag),
		  .restart(~KEY[2]),
		  .plot(PLOT), 
		  .XOut(X), 
		  .YOut(Y), 
		  .CLROut(CLR),
		  .timeOne(timeOne),
		  .timeTen(timeTen),
		  .highOne(highOne),
		  .highTen(highTen),
		  .scoreOne(scoreOne),
		  .scoreTen(scoreTen),
		  .letter1(letter1), 
		  .letter2(letter2), 
		  .letter3(letter3), 
		  .letter4(letter4), 
		  .letter5(letter5)
		  );
	
	vga_adapter VGA(
			.resetn(KEY[0]),
			.clock(CLOCK_50),
			.colour(CLR),
			.x(X),
			.y(Y),
			.plot(PLOT),
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "Visuals/basketball.mif";
		
		hex_decoder h5(scoreTen, HEX5);	
		hex_decoder h4(scoreOne, HEX4);
		hex_decoder h3(highTen, HEX3);	
		hex_decoder h2(highOne, HEX2);
		hex_decoder h1(timeTen, HEX1);	
		hex_decoder h0(timeOne, HEX0);
	
endmodule 