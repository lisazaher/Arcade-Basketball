module clockdelay(input clk, resetn, output reg enable, trigger, output reg [5:0] frame);
	reg [25:0] count;
	reg [25:0] framecount;
	reg [1:0] trigCount;
	
	always @ (posedge clk) begin
		if (!resetn) begin
			trigCount <= 2'd3;
			enable <= 1'b0;
			frame <= 6'd0;
			framecount <= 26'd999_999;
			count <= 26'd49_999_999; //change number for simulations to 4
		end
		
		
		//reset both so framecount and count are aligned
		if (count == 26'd0 | framecount == 26'd0 | trigCount == 2'd0) begin
			if (trigCount == 2'd0) begin
				trigger <= 1'b1;
				trigCount <= 2'd3;
				enable <= 1'b1;
				trigCount <= trigCount + 1;
				frame <= 6'd0;
				framecount <= 26'd999_999;
				count <= 26'd49_999_999;
			end
			else if (count == 26'd0) begin
				enable <= 1'b1;
				trigCount <= trigCount + 1;
				frame <= 6'd0;
				framecount <= 26'd999_999;
				count <= 26'd49_999_999; //change number for simulations to 4
			end
			else if (framecount == 26'd0) begin
				framecount <= 26'd999_999;
				frame <= frame+1;
			end
				
		end
		else begin
			enable <= 1'b0;
			trigger <= 1'b0;
			count <= count - 1;
			framecount <= framecount -1;
		end
		
		
		/*frame count 
		if (framecount == 6'd0) begin
			framecount <= 26'd999_999;
			frame <= frame + 1;
			end
		else if (frame == 6'd49) begin
			frame <= 6'd0;
		end
		else framecount <= framecount -1;*/
	end
endmodule
	

			