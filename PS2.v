module PS2(
	// Inputs
	CLOCK_50,
	KEY,

	// Bidirectionals
	PS2_CLK,
	PS2_DAT,
	
	// Outputs
	H0,
	H1,
	H2,
	H3,
	H4,
	H5,
	symbol1, symbol2, symbol3, symbol4, symbol5,
	doneentry
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/

// Inputs
input				CLOCK_50;
input		[3:0]	KEY;

// Bidirectionals
inout				PS2_CLK;
inout				PS2_DAT;

// Outputs
output		[6:0]	H0;
output		[6:0]	H1;
output		[6:0]	H2;
output		[6:0]	H3;
output		[6:0]	H4;
output		[6:0]	H5;
output [5:0] symbol1, symbol2, symbol3, symbol4, symbol5;
output reg doneentry;
/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires
wire		[7:0]	ps2_key_data;
wire				ps2_key_pressed;


// Internal Registers
reg			[7:0]	last_data_received;

//enable signals for the registers
wire draw, go;
reg donedraw;

// State Machine Registers
reg [7:0] L5, L4, L3, L2, L1;
reg [2:0] count;

assign go = ~KEY[1];
/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/

//call the control path module
PS2_control psc(.press(ps2_key_pressed), 
					.clock(CLOCK_50),
				.go(go),	
					.reset(~KEY[0]),
					.done(doneentry), 
					.donedraw(donedraw),
					.letteren(letteren),  
					.draw(draw)
					);

/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

always @(posedge CLOCK_50)
begin
	if (KEY[0] == 1'b0| go) begin
		last_data_received <= 8'h00;
		L5 <= 8'h00;
		L4 <= 8'h00;
		L3 <= 8'h00;
		L2 <= 8'h00;
		L1 <= 8'h00;
		count <= 3'b0;
		doneentry = 1'b0;
	end
	else if (ps2_key_pressed == 1'b1)
		last_data_received <= ps2_key_data;
		
	if (letteren) begin 
		count <= count + 1;
		if (last_data_received == 8'h5A | count == 3'b100) doneentry = 1'b1;
		else doneentry = 1'b0;
		if(count == 3'b0) L5 <= last_data_received;
		else if (count == 3'b1) L4 <= last_data_received;
		else if (count == 3'b10) L3 <= last_data_received;
		else if (count == 3'b11) begin
			L2 <= last_data_received;
			
		end
		else if (count == 3'b100) begin 
				L1 <= last_data_received;
				count <= 3'b0;
				doneentry = 1'b1;
			end
	end

	if (draw) begin
		donedraw = 1'b1;
		doneentry = 1'b0;
	end
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/
assign HEX5 = 7'h7F;

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

PS2_Controller PS2 (
	// Inputs
	.CLOCK_50				(CLOCK_50),
	.reset				(~KEY[0]),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(ps2_key_pressed)
);

//rewrite hexadecimal to take in the 8 bit signal, and draw it

Hexadecimal_To_Seven_Segment h5 (
	// Inputs
	.hex_number			(L5),

	// Bidirectional

	// Outputs
	.seven_seg_display	(H4),
	.symbol(symbol5)
);

Hexadecimal_To_Seven_Segment h4 (
	// Inputs
	.hex_number			(L4),

	// Bidirectional

	// Outputs
	.seven_seg_display	(H3),
	.symbol(symbol4)
);

Hexadecimal_To_Seven_Segment h3 (
	// Inputs
	.hex_number			(L3),

	// Bidirectional

	// Outputs
	.seven_seg_display	(H2),
	.symbol(symbol3)
);

Hexadecimal_To_Seven_Segment h2 (
	// Inputs
	.hex_number			(L2),

	// Bidirectional

	// Outputs
	.seven_seg_display	(H1),
	.symbol(symbol2)
);

Hexadecimal_To_Seven_Segment h0 (
	// Inputs
	.hex_number			(L1),

	// Bidirectional

	// Outputs
	.seven_seg_display	(H0),
	.symbol(symbol1)
);

assign H5 = 7'b1111111;

endmodule
