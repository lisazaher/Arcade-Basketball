module display_dp(input clk, reset, ld_timeOne, ld_timeTen, ld_scoreOne, ld_scoreTen, input [5:0] letter1, letter2, letter3, letter4, letter5, curr5, curr4, curr3, curr2, curr1, input [5:0] frame, input [3:0]timeOne, timeTen, scoreOne, scoreTen, highOne, highTen, output reg [7:0]XLoc, output reg [6:0]YLoc, output reg [5:0]Symbol, output reg [2:0] scale, output reg goDraw);
	always @ (posedge clk) begin
		//WILL END UP BEING HIGH SCORE RESET
		if (!reset) begin
			XLoc <= 8'd43;
			YLoc <= 7'd45;
			Symbol <= {2'b0, timeTen}; 
			scale <= 3'b100;
			goDraw <= 0;
		end
		
		//if (ld_timeOne) begin
		//LOAD TIME
		else if (frame == 6'd25) begin
			XLoc <= 8'd84;
			YLoc <= 7'd45;
			Symbol <= {2'b0, timeOne};
			goDraw <= 1'b1;
			scale <= 3'b100;
		end
		else if (frame == 6'd26) begin
			XLoc <= 8'd43;
			YLoc <= 7'd45;
			Symbol <= {2'b0, timeTen};
			goDraw <= 1'b1;
			scale <= 3'b100;
		end
		else if (frame == 6'd3 || frame == 6'd33 || frame == 6'd3) begin
			XLoc <= 8'd56;
			YLoc <= 7'd93;
			Symbol <= curr5;
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		//LOAD CURRENT NAME AND SCORE		
		else if (frame == 6'd4 || frame == 6'd34 || frame == 6'd44) begin
			XLoc <= 8'd64;
			YLoc <= 7'd93;
			Symbol <= curr4;
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		else if (frame == 6'd5 ||frame == 6'd35 || frame == 6'd45) begin
			XLoc <= 8'd72;
			YLoc <= 7'd93;
			Symbol <= curr3;
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		else if (frame == 6'd6 || frame == 6'd36 || frame == 6'd46) begin
			XLoc <= 8'd80;
			YLoc <= 7'd93;
			Symbol <= curr2;
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		else if (frame == 6'd7 || frame == 6'd17 || frame == 6'd37 || frame == 6'd47) begin
			XLoc <= 8'd88;
			YLoc <= 7'd93;
			Symbol <= curr1;
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		else if (frame == 6'd8 || frame == 6'd18 || frame == 6'd28 || frame == 6'd38 || frame == 6'd48) begin
			XLoc <= 8'd100;
			YLoc <= 7'd93;
			Symbol <= {2'b0, scoreTen};
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		else if (frame == 6'd9|| frame == 6'd19 || frame == 6'd29 || frame == 6'd39 || frame == 6'd49) begin
			XLoc <= 8'd108;
			YLoc <= 7'd93;
			Symbol <= {2'b0, scoreOne};
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		//load high score one
		else if (frame == 6'd10) begin
			XLoc <= 8'd124;
			YLoc <= 7'd23;
			Symbol <= {2'b0, highOne};
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		//load high score ten
		else if (frame == 6'd11) begin
			XLoc <= 8'd116;
			YLoc <= 7'd23;
			Symbol <= {2'b0, highTen};
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		//name
		else if (frame == 6'd12) begin
			XLoc <= 8'd71;
			YLoc <= 7'd23;
			Symbol <= {letter5};
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		else if (frame == 6'd13) begin
			XLoc <= 8'd79;
			YLoc <= 7'd23;
			Symbol <= {letter4};
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		else if (frame == 6'd14) begin
			XLoc <= 8'd87;
			YLoc <= 7'd23;
			Symbol <= letter3;
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		else if (frame == 6'd15) begin
			XLoc <= 8'd95;
			YLoc <= 7'd23;
			Symbol <= letter2;
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		else if (frame == 6'd16) begin
			XLoc <= 8'd103;
			YLoc <= 7'd23;
			Symbol <= letter1;
			goDraw <= 1'b1;
			scale <= 3'b001;
		end
		else
			goDraw <= 1'b0;
	end
endmodule
