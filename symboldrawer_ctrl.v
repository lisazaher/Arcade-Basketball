module symboldrawer_ctrl(clk, reset, go, gobox, donebox, done, ld_init, ld_add, ld_addrom, add_enable, updateloc, updateinc);
input clk, reset, go, donebox, done;
output reg ld_init, ld_add, ld_addrom, add_enable, gobox, updateloc, updateinc;

reg [3:0] currentstate, nextstate;

localparam
	WAIT = 4'd0,
	LOADR = 4'd1,
	LOADA = 4'd2,
	LOADROMA = 4'd3,
	DRAW = 4'd4,
	CHECKDONE = 4'd5,
	ADD = 4'd6,
	STARTBOX = 4'd7,
	UPINC = 4'd8,
	UPLOC = 4'd9;
	
	
	always @ (posedge clk) begin
		if (!reset) currentstate <= WAIT;
		else currentstate <= nextstate;
	end

always@(*)
begin
	//defaults
	ld_init = 1'b0;
	ld_add = 1'b0;
	ld_addrom = 1'b0;
	gobox= 1'b0;
	add_enable = 1'b0;
	updateloc = 1'b0;
	updateinc = 1'b0;
	nextstate = currentstate;
	
	case(currentstate)
		WAIT: if(go) nextstate = LOADR;
		LOADR: begin 
			ld_init = 1'b1;
			nextstate = LOADA;
		end
		LOADA: begin
			ld_add = 1'b1;
			nextstate = LOADROMA;
		end
		LOADROMA: begin
			ld_addrom = 1'b1;
			nextstate = UPINC;
		end
		UPINC: begin
			updateinc = 1'b1;
			nextstate= UPLOC;
		end
		UPLOC: begin
			updateloc = 1'b1;
			nextstate = STARTBOX;
		end
		STARTBOX: begin
			gobox= 1'b1;
			nextstate = DRAW;
		end
		DRAW: begin
			if (donebox) nextstate = CHECKDONE;
		end
		CHECKDONE: nextstate = done? WAIT: ADD;
		ADD: begin
			add_enable = 1'b1;
			nextstate = UPINC;
		end


	endcase
	
end

endmodule 