module timer (input clk, resetn, go, doneSave, output done, countFlag, enableDelay, output [3:0] one_digit, ten_digit, output [5:0] frame);

	wire ld_wait, ld_set, ld_one, ld_ten, changeTen; 

	timer_ctrl tc(.clk(clk), 
				  .resetn(resetn), 
				  .go(go), 
				  .done(done),
			     .doneSave(doneSave),
				  .changeTen(changeTen), 
				  .ld_wait(ld_wait), 
				  .ld_set(ld_set), 
				  .ld_one(ld_one), 
				  .ld_ten(ld_ten),
				  .countFlag(countFlag),
				  .frame(frame));
				  
	timer_datapath td(.clk(clk),
					  .resetn(resetn), 
					  .ld_wait(ld_wait),
					  .ld_set(ld_set), 
					  .ld_one(ld_one), 
					  .ld_ten(ld_ten), 
					  .countOne(one_digit), 
					  .countTen(ten_digit), 
					  .done(done), 
					  .changeTen(changeTen));
endmodule 
