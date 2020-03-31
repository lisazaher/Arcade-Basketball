		
module display_ctrl(input clk, reset, drawDone, output reg ld_timeOne, ld_timeTen, ld_scoreOne, ld_scoreTen);
	
	reg [3:0] currentState, nextState;
	
	localparam RESET = 4'b0,
				  WAIT = 4'b1,
				  TIMETEN = 4'b10,
				  WAIT_TIMETEN = 4'b11,
				  TIMEONE = 4'b100,
				  WAIT_TIMEONE = 4'b101,
				  SCOREONE = 4'b110,
				  WAIT_SCOREONE = 4'b111,
				  SCORETEN = 4'b1000,
				  WAIT_SCORETEN = 4'b1001;
				  
	
	always @ (posedge clk)
		if(!reset) currentState <= RESET;
		//else if (save) currentState <= SAVEWAIT;
		else currentState <= nextState;
	
	always @ (*) begin
		
		ld_timeTen = 1'b0;
		ld_timeOne = 1'b0;
		ld_scoreTen = 1'b0;
		ld_scoreOne = 1'b0;
		nextState = currentState;
		
		case (currentState)
			RESET: nextState = WAIT;
			WAIT: begin 
				nextState = SCORETEN;
				ld_scoreTen = 1'b1;
			end
			
			TIMETEN: begin
				nextState = WAIT_TIMETEN;
			end
			
			WAIT_TIMETEN: begin 
				if (drawDone) begin
					nextState = SCOREONE;
					ld_scoreOne = 1'b1;
				end
			end
			
			TIMEONE: begin
				nextState = WAIT_TIMEONE;
			end
			
			WAIT_TIMEONE: begin 
				if (drawDone) nextState = WAIT;
			end
			SCORETEN: begin
				nextState = WAIT_SCORETEN;
			end
			WAIT_SCORETEN:  begin
				if (drawDone) begin
					nextState = TIMETEN;
					ld_timeTen = 1'b1;
				end
			end
			
			SCOREONE: begin
				nextState = WAIT_SCOREONE;
			end
			
			WAIT_SCOREONE: begin 
				if (drawDone) begin
					nextState = TIMEONE;
					ld_timeOne = 1'b1;
				end
			end
			
		endcase
	end
endmodule
			