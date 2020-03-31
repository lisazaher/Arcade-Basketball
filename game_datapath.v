module game_datapath (input clk, resetn, ld_reset, ld_wait, ld_one, ld_ten, ld_save, input [5:0] letter1, letter2, letter3, letter4, letter5, output reg [3:0]scoreOne, scoreTen, highOne, highTen, output reg [5:0] high5, high4, high3, high2, high1);

	always @ (posedge clk) begin
		if (ld_reset) begin
			scoreOne <= 4'd0;
			scoreTen <= 4'd0;
			highOne <= 4'd0;
			highTen <= 4'd0;
			high5 <= 6'd36;
			high4 <= 6'd36;
			high3 <= 6'd36;
			high2 <= 6'd36;
			high1 <= 6'd36;
		end

		if (ld_wait) begin
			scoreOne <= 4'd0;
			scoreTen <= 4'd0;
		end

		if (ld_one) begin
			if (scoreOne == 4'd9)
				scoreOne <= 4'd0;
			else 
				scoreOne <= scoreOne + 1'b1;
		end

		if (ld_ten) begin
			if (scoreOne == 4'd0)
				scoreTen <= scoreTen + 1;
		end

		if (ld_save) begin
			if (scoreTen > highTen) begin
				highTen <= scoreTen;
				highOne <= scoreOne;
			end
			if ((scoreTen == highTen) && (scoreOne > highOne)) begin
				highTen <= scoreTen;
				highOne <= scoreOne;
				high5 <= letter5;
				high4 <= letter4;
				high3 <= letter3;
				high2 <= letter2;
				high1 <= letter1;
			end
		end
	end
endmodule


