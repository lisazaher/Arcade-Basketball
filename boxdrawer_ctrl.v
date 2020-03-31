module boxdrawer_ctrl(clk, reset, go, x_done, y_done, set, x_en, y_en, resetx, plot, done, setx,sety);
input clk, go, x_done, y_done, reset;
output reg set, x_en, y_en, resetx, plot, done, setx,sety;

reg [3:0] currentstate, nextstate;

localparam [3:0]
	WAIT = 4'd0,
	LOAD = 4'd1,
	CHECKX = 4'd2,
	DRAW = 4'd3,
	ADDY = 4'd4,
	CHECKY = 4'd5,
	SETX = 4'd6,
	SETY= 4'd7,
	ADDX = 4'd8;

always@(posedge clk) begin 
	if (!reset) currentstate<= WAIT;
	else currentstate<=nextstate;
end

always@(*) begin
	set= 1'b0; 
	x_en=1'b0; 
	y_en=1'b0; 
	resetx=1'b0; 
	plot=1'b0;
	done = 1'b0;
	setx = 1'b0;
	sety= 1'b0;
	nextstate = currentstate;
	case(currentstate) 
		WAIT: if (go) nextstate = LOAD;
		LOAD: begin 
			set = 1'b1;
			nextstate = DRAW;
		end
		DRAW: begin 
			plot = 1'b1;
			nextstate = CHECKX;
		end
		ADDX: begin
			x_en = 1'b1;
			nextstate = SETX;
		end
		SETX: begin 
			setx= 1'b1;
			nextstate = DRAW;
		end
		CHECKX: begin 
			if (x_done) nextstate = ADDY;
			else nextstate = ADDX;
		end
		ADDY: begin 
			y_en = 1'b1;
			resetx= 1'b1;
			nextstate = SETY;
		end
		SETY: begin 
			setx= 1'b1;
			sety= 1'b1;
			nextstate= CHECKY;
		end
		CHECKY: begin 
			if(y_done) begin
				done = 1'b1;
				nextstate = WAIT;
			end
			else nextstate = DRAW;
		end
	endcase
end

endmodule 