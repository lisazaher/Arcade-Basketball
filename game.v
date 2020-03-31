module game(input clk, go, reset, inputOne, saveDone, restart, input [5:0] letter1, letter2, letter3, letter4, letter5, output plot, countFlag, output [7:0]XOut, output [6:0]YOut, output[2:0]CLROut, output [3:0] timeOne, timeTen, highOne, highTen, scoreOne, scoreTen);
	
	wire [7:0] X;
	wire [6:0] Y;
	wire [5:0] Symbol, frame;
	wire [5:0] high5, high4, high3, high2, high1;
	wire [2:0] Scale, Colour;
	wire goDraw, ld_timeOne, ld_timeTen, ld_scoreOne, ld_scoreTen, drawDone, doneGame, cf;
	assign Colour = 3'b111;
	assign countFlag = cf;

	//DISPLAY COMMUNICATES WHAT TO DRAW AND WHERE
	display_ctrl dc(.clk(clk), 
					.reset(reset), 
					.drawDone(drawDone), 
					.ld_timeOne(ld_timeOne), 
					.ld_timeTen(ld_timeTen),
					.ld_scoreOne(ld_scoreOne),
					.ld_scoreTen(ld_scoreTen));

	display_dp dd(.clk(clk), 
				  .reset(reset), 
				  .ld_timeOne(ld_timeOne), 
				  .ld_timeTen(ld_timeTen), 
				  .ld_scoreOne(ld_scoreOne),
				  .ld_scoreTen(ld_scoreTen),
				  .timeOne(timeOne), 
				  .timeTen(timeTen), 
				  .scoreOne(scoreOne),
				  .scoreTen(scoreTen),
				  .highOne(highOne),
				  .highTen(highTen),
				  .XLoc(X), 
				  .YLoc(Y), 
				  .Symbol(Symbol), 
				  .scale(Scale),
				  .goDraw(goDraw),
				  .frame(frame),
				  .letter1(high1), 
				  .letter2(high2),
				  .letter3(high3),
				  .letter4(high4), 
				  .letter5(high5),
				  .curr5(letter5), 
				  .curr4(letter4), 
				  .curr3(letter3), 
				  .curr2(letter2), 
				  .curr1(letter1)
					);

	//DETERMINES THE SCORING
	gameState gs(.clk(clk), 
				 .go(go), //WILL BE A BUTTON OF SOME SORT
				 .resetn(reset), 
				 .inputOne(inputOne),  
				 .done(doneGame), //INPUT
				 .doneSave(saveDone), 
				 .countFlag(cf),
				 .restart(restart),
				 .scoreOne(scoreOne), 
				 .scoreTen(scoreTen), 
				 .highOne(highOne), 
				 .highTen(highTen), //name inputs
				 .letter1(letter1),
				 .letter2(letter2), 
				 .letter3(letter3),
				 .letter4(letter4),
				 .letter5(letter5), //high score name
				 .high5(high5),
				 .high4(high4),
				 .high3(high3),
				 .high2(high2),
				 .high1(high1)
		  );

	//DETERMINES THE TIME
	timer t0(.clk(clk), 
			 .resetn(reset), 
			 .go(go), //WILL BE A BUTTON OF SOME SORT
			 .done(doneGame), //NOT SURE WHAT THIS IS GONNA BE - OUTPUT
			 .countFlag(cf),
			 .doneSave(saveDone),
			 .one_digit(timeOne), 
			 .ten_digit(timeTen),
			 .frame(frame));

	//DRAWS THE RIGHT THINGS
	drawMod dm(.clk(clk), 
			   .reset(reset), 
			   .go(goDraw), 
			   .symbolIn(Symbol), 
			   .scaleIn(Scale),
				.XLoc(X),
				.YLoc(Y),
			   .donesym(drawDone), 
			   .plot(plot), 
			   .xvga(XOut), 
			   .yvga(YOut), 
			   .clrvga(CLROut));
endmodule
	
	
	