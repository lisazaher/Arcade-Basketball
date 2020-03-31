module gameclock(clock,resetn, enable);
input clock, resetn;
output reg enable;

reg [27:0] count;

always@(posedge clock) begin
	if(!resetn) begin
		count <= 28'd149_999_999;
		enable <= 1'b0;
	end
	if (count == 28'd0) begin
		enable <= 1'b1;
	end
	else begin
		if (count > 28'd0) count <= count -1;
		enable <= 1'b0;
	end
end
endmodule 