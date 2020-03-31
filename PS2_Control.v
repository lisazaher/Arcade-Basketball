module PS2_control(input press, clock, reset, go,
						input done, donedraw,
						output reg letteren, draw);
						
reg [4:0] currentstate, nextstate;

localparam HOLD = 5'd1,
				START = 5'd13,
				STARTx = 5'd14,
				Lx = 5'd2,
				LOADx = 5'd13,
				CHECKLx = 5'd3,
				BREAK = 5'd4,
				AFTERBREAK = 5'd5,
				NEW = 4'd6,
				DRAW = 5'd12;

always@(posedge clock) begin
	if(reset) currentstate<= HOLD;
	else currentstate <= nextstate;
end
				
always@(*) begin
	//default
	letteren = 1'b0;
	draw =1'b0;
	nextstate = currentstate;
	
	case(currentstate)
	HOLD: if (go) nextstate = START;
//	START: if (~go) nextstate = STARTx;
	STARTx: if (press) nextstate = Lx;
	Lx: begin
		if(!press) nextstate = LOADx;
	end
	LOADx: begin
		letteren = 1'b1;
		nextstate = CHECKLx;
	end
	CHECKLx: begin
		if(done) nextstate = DRAW;
		else if(press) nextstate = BREAK;
	end
	BREAK: if(!press) nextstate = AFTERBREAK;
	AFTERBREAK: if(press) nextstate = NEW;
	NEW: if(!press) nextstate = STARTx;
	DRAW: begin
		draw = 1'b1;
		if(donedraw) nextstate = HOLD;
	end
	default: nextstate = HOLD;
	endcase
end
endmodule 