module timer_datapath(input clk, resetn, ld_wait, ld_set, ld_one, ld_ten, output reg [4:0]countOne, countTen, output reg done, changeTen);

	always @ (posedge clk) begin
		if (ld_wait) begin
			countOne <= 4'd0;
			countTen <= 4'd2;
			done <= 1'b0;
			changeTen <= 1'b0;
		end
		
		if (ld_set) begin
			countOne <= 4'd0;
			countTen <= 4'd2;
			done <= 1'b0;
			changeTen <= 1'b0;
		end
		
		if (ld_one) begin
			if (countOne == 4'd0 && countTen == 4'd0) changeTen <= 1'b1;
			else if (countOne == 4'd0) begin
				changeTen <= 1'b1;
				countOne <= 4'd9;
			end
			else 
				countOne <= countOne - 1;
		end
		
		if (ld_ten) begin
			changeTen <= 1'b0;
			if (countTen == 4'd0)
				done <= 1'b1;
			else 
				countTen <= countTen - 1;
		end
	end
endmodule 
		
				
	