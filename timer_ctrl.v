module timer_ctrl (input clk, resetn, go, done, doneSave, changeTen, output reg ld_wait, ld_set, ld_one, ld_ten, countFlag, output [5:0] frame);
	
	//INPUT/OUTPUT
	reg [3:0] currentState, nextState;
	wire enable;
	
	localparam WAIT = 4'b0,
				  GO = 4'b1,
				  SET = 4'b10,
				  HOLD = 4'b11,
				  DECONE = 4'b100,
				  DECTEN = 4'b101,
				  DONE = 4'b110,
				  DECHOLD = 4'b111,
				  ISDONE = 4'b1000,
				  SAVE = 4'b1001;
				  
	clockdelay cd (.clk(clk), 
					   .resetn(resetn), 
						.enable(enable),
						.frame(frame));
	
	always @ (posedge clk) begin
		if (!resetn) currentState = WAIT;
		else currentState = nextState;
	end 
	
	always @ (*) begin
		ld_wait = 1'b0;
		ld_set = 1'b0;
		ld_one = 1'b0;
		ld_ten = 1'b0;
		countFlag = 1'b0;
		nextState = currentState;
		
		case (currentState)
			WAIT: begin
				ld_wait = 1'b1;
				if (go) nextState = GO;
			end
			
			GO: if (~go) nextState = SET;
		
			
			SET: begin //MIGHT BE REDUNDANT
				ld_set = 1'b1;
				nextState = HOLD;
			end
			
			HOLD: begin 
				if (enable) nextState = DECONE; //SEND RESET SIGNAL?
				countFlag = 1'b1;
			end
	
			
			DECONE: begin
					ld_one = 1'b1;
					countFlag = 1'b1;
					nextState = DECHOLD;
			end
			
			DECHOLD: begin
					nextState = changeTen ? DECTEN:HOLD;
					countFlag = 1'b1;
			end
			
			DECTEN: begin
				countFlag = 1'b1;
				ld_ten = 1'b1;
				nextState = ISDONE;
			end
			ISDONE: nextState = done ? SAVE:HOLD;
			SAVE: nextState = doneSave ? WAIT:SAVE;
		endcase
	end
endmodule
				
			
				
			
		
		