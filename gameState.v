module gameState(input clk, go, resetn, inputOne, done, doneSave, countFlag, restart, input [5:0] letter1, letter2, letter3, letter4, letter5, output [3:0] scoreOne, scoreTen, highOne, highTen, output [3:0]state, next, output [5:0] high5, high4, high3, high2, high1);

	wire ld_reset, ld_wait, ld_one, ld_ten, ld_save;

	game_ctrl gc(.clk(clk),
				 .resetn(resetn), 
				 .inputOne(inputOne), 
				 .go(go), 
				 .done(done), 
				 .doneSave(doneSave),
				 .countFlag(countFlag),
				 .restart(restart),
				 .ld_reset(ld_reset), 
				 .ld_wait(ld_wait), 
				 .ld_one(ld_one), 
				 .ld_ten(ld_ten), 
				 .ld_save(ld_save),
				 .state(state),
				 .next(next));

	game_datapath gd(.clk(clk), 
					 .resetn(resetn), 
					 .ld_reset(ld_reset), 
					 .ld_wait(ld_wait), 
					 .ld_one(ld_one), 
					 .ld_ten(ld_ten), 
					 .ld_save(ld_save), 
					 .scoreOne(scoreOne), 
					 .scoreTen(scoreTen), 
					 .highOne(highOne), 
					 .highTen(highTen),
					 .letter1(letter1), 
					 .letter2(letter2), 
					 .letter3(letter3),
					 .letter4(letter4), 
					 .letter5(letter5),
					 .high5(high5),
					 .high4(high4),
					 .high3(high3),
					 .high2(high2),
					 .high1(high1)
					 );
endmodule