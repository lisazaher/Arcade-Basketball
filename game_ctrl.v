module game_ctrl(input clk, resetn, inputOne, go, done, doneSave, countFlag, restart, output reg ld_reset, ld_wait, ld_one, ld_ten, ld_save, output [3:0] state, next);

	reg [3:0] currentState, nextState;
	reg startDelay;
	wire delayTime, trigger;
	assign state = currentState;
	assign next = nextState;

	gameclock gc (.clock(clk),
			   .resetn(~startDelay),
			   .enable(trigger));

	localparam RESET = 4'b0,
			   WAIT = 4'b1,
			   GO = 4'b10,
			   GAME = 4'b11,
			   SCORE_INT = 4'b100,
			   SCORE_ONE = 4'b101,
			   SCORE_TEN = 4'b110,
			   SAVE = 4'b111;

	always @ (posedge clk) begin
		if (!resetn ) currentState = RESET;
		else if (restart) currentState = GAME;
		else if (done) currentState = SAVE;
		else currentState = nextState;
	end

	always @ (*) begin
		ld_reset = 1'b0;
		ld_wait = 1'b0;
		ld_one = 1'b0;
		ld_ten = 1'b0;
		ld_save = 1'b0;
		startDelay = 1'b0;
		nextState = currentState;

		case (currentState)
			RESET: begin
				ld_reset = 1'b1;
				nextState = WAIT;
			end

			WAIT: begin
				ld_wait = 1'b1;
				if (go) nextState = GO;
			end

			GO: if (~go) nextState = GAME;
			GAME: begin
				if (inputOne) begin 
					nextState = SCORE_ONE;
				end
			end
			SCORE_INT: begin 
				if (trigger) nextState = GAME;
			end

			SCORE_ONE: begin
				ld_one = 1'b1;
				nextState = SCORE_TEN;
			end

			SCORE_TEN: begin
				ld_ten = 1'b1;
				nextState = SCORE_INT;
				startDelay = 1'b1;
			end

			SAVE: begin
				if (doneSave) begin 
					ld_wait = 1'b1;
					nextState = WAIT;
				end
				ld_save = 1'b1;
			end
			default: nextState = GAME;
		endcase
	end
endmodule 


