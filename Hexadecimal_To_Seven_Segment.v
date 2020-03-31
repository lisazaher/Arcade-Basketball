/******************************************************************************
 *                                                                            *
 * Module:       Hexadecimal_To_Seven_Segment                                 *
 * Description:                                                               *
 *      This module converts hexadecimal numbers for seven segment displays.  *
 *                                                                            *
 ******************************************************************************/

module Hexadecimal_To_Seven_Segment (
	// Inputs
	hex_number,

	// Bidirectional

	// Outputs
	seven_seg_display, 
	symbol
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input		[7:0]	hex_number;

// Bidirectional

// Outputs
output	reg	[6:0]	seven_seg_display;
output reg [5:0] symbol;

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/
always@(*) begin
	case(hex_number)
	//0
	8'h45: begin 
		seven_seg_display = 7'b1000000;
		symbol = 6'd0;
	end
	//1
	8'h16: begin 
		seven_seg_display = 7'b1111001;
		symbol = 6'd1;
	end
	//2
	8'h1E: begin 
		seven_seg_display = 7'b0100100;
		symbol = 6'd2;
	end
	//3
	8'h26: begin 
		seven_seg_display = 7'b0110000;
		symbol = 6'd3;
	end
	//4
	8'h25: begin 
		seven_seg_display = 7'b0011001;
		symbol = 6'd4;
	end
	//5
	8'h2E: begin
		seven_seg_display = 7'b0010010;
		symbol = 6'd5;
	end
	
	//6
	8'h36: begin 
		seven_seg_display = 7'b0000010;
		symbol = 6'd6;
	end
	//7
	8'h3D: begin 
		seven_seg_display = 7'b1111000;
		symbol = 6'd7;
	end
	
	//8
	8'h3E: begin 
		seven_seg_display = 7'b0;
		symbol = 6'd8;
	end 
	//9
	8'h46: begin 
		seven_seg_display = 7'b0010000;
		symbol = 6'd9;
	end 
	//A
	8'h1C: begin 
		seven_seg_display = 7'b0001000;
		symbol = 6'd10;
	end
	//B - same as 8 in this case
	8'h32: begin 
		seven_seg_display = 7'b0;
		symbol = 6'd11;
	end 
	//C
	8'h21: begin 
		seven_seg_display = 7'b1000110;
		symbol = 6'd12;
	end 
	//D - same as 0
	8'h23: begin 
		seven_seg_display = 7'b1000000;
		symbol = 6'd13;
	end
	
	//E
	8'h24: begin 
		seven_seg_display = 7'b0000110;
		symbol = 6'd14;
	end 
	//F
	8'h2B: begin 
		seven_seg_display = 7'b0001110;
		symbol = 6'd15;
	end 
	//G - same as 6
	8'h34: begin 
		seven_seg_display = 7'b0000010;
		symbol = 6'd16;
	end
	//H
	8'h33: begin 
		seven_seg_display = 7'b0001001;
		symbol = 6'd17;
	end
	//I - same as 1
	8'h43: begin 
		seven_seg_display = 7'b1111001;
		symbol = 6'd18;
	end
	// J
	8'h3B: begin 
		seven_seg_display = 7'b1110001;
		symbol = 6'd19;
	end
	//K ?? same as H
	8'h42: begin 
		seven_seg_display = 7'b0001001;
		symbol = 6'd20;
	end
	//L
	8'h4B: begin 
		seven_seg_display = 7'b1000111;
		symbol = 6'd21;
	end
	//M ?????? make it 0 for now bc why not
	8'h3A: begin 
		seven_seg_display = 7'b1000000;
		symbol = 6'd22;
	end
	//N ??? same
	8'h31: begin 
		seven_seg_display = 7'b0101011;
		symbol = 6'd23;
	end
	// O same as 0
	8'h44: begin 
		seven_seg_display = 7'b1000000;
		symbol = 6'd24;
	end
	//P
	8'h4D: begin 
		seven_seg_display = 7'b0001100;
		symbol = 6'd25;
	end
	// Q??? just make it 0 for now
	8'h15: begin 
		seven_seg_display = 7'b1000000;
		symbol = 6'd26;
	end
	//R - looks like A
	8'h2D: begin 
		seven_seg_display = 7'b0001000;
		symbol = 6'd27;
	end
	//S - looks like 5
	8'h1B: begin 
		seven_seg_display = 7'b0010010;
		symbol = 6'd28;
	end
	//T 
	8'h2C: begin 
		seven_seg_display = 7'b0000111;
		symbol = 6'd29;
	end
	//U
	8'h3C: begin 
		seven_seg_display = 7'b1000001;
		symbol = 6'd30;
	end
	//V - looks like U
	8'h2A: begin 
		seven_seg_display = 7'b1000001;
		symbol = 6'd31;
	end
	//W ??? make it 0
	8'h1D: begin 
		seven_seg_display = 7'b1000000;
		symbol = 6'd32;
	end
	//X ?? make it 0
	8'h22: begin 
		seven_seg_display = 7'b1000000;
		symbol = 6'd33;
	end
	//Y
	8'h35: begin 
		seven_seg_display = 7'b0011001;
		symbol = 6'd34;
	end
	//Z
	8'h1A: begin 
		seven_seg_display = 7'b0100100;
		symbol = 6'd35;
	end
	8'hF0: seven_seg_display = 7'b1111111;
	default: begin 
		seven_seg_display = 7'b1111111; //0
		symbol = 6'd36;
	end
	endcase
end
 
//assign seven_seg_display =
//		({7{(hex_number == 4'h0)}} & 7'b1000000) |
//		({7{(hex_number == 4'h1)}} & 7'b1111001) |
//		({7{(hex_number == 4'h2)}} & 7'b0100100) |
//		({7{(hex_number == 4'h3)}} & 7'b0110000) |
//		({7{(hex_number == 4'h4)}} & 7'b0011001) |
//		({7{(hex_number == 4'h5)}} & 7'b0010010) |
//		({7{(hex_number == 4'h6)}} & 7'b0000010) |
//		({7{(hex_number == 4'h7)}} & 7'b1111000) |
//		({7{(hex_number == 4'h8)}} & 7'b0000000) |
//		({7{(hex_number == 4'h9)}} & 7'b0010000) |
//		({7{(hex_number == 4'hA)}} & 7'b0001000) |
//		({7{(hex_number == 4'hB)}} & 7'b0000011) |
//		({7{(hex_number == 4'hC)}} & 7'b1000110) |
//		({7{(hex_number == 4'hD)}} & 7'b0100001) |
//		({7{(hex_number == 4'hE)}} & 7'b0000110) |
//		({7{(hex_number == 4'hF)}} & 7'b0001110); 

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/


endmodule


