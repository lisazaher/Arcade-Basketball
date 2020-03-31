module symboldrawer_datapath (clk, reset, Xin, Yin, Clrin, Scalein, Symbol, Clrsym, Xsym, Ysym, Scalesym, donebox,go, done, ld_ini, ld_add, ld_romadd, add_enable, updateloc, updateinc);
input [7:0] Xin;
input [6:0] Yin;
input [2:0] Clrin, Scalein;
input [5:0] Symbol;

//signals
input clk, go, donebox, reset, ld_ini, ld_add, ld_romadd, add_enable, updateloc, updateinc;
wire pixel;

//registers
reg [7:0] X;
reg [6:0] Y;
reg [5:0] Symbolreg;
reg [2:0] Clr;
reg [6:0] incX, incY;
reg [11:0] AddressLower, AddressUpper, Address;


//outputs
output reg [7:0] Xsym;
output reg [6:0] Ysym;
output reg [2:0] Clrsym;
output reg [5:0] Scalesym;
output reg done;

Sprites s(.clock(clk), .address(Address), .q(pixel));

always@(posedge clk)
begin
	//set up connections that are always happening
	//Scalesym <= Scalein;
	if (!reset) begin
		done = 1'b0;
		X <= 8'b0;
		Y <= 7'b0;
		Clr <= 3'b0;
		Address <= 12'b0;
	end
	else if (ld_ini) begin 
		X <= Xin;
		Y <= Yin;
		Clr <= Clrin;
		Scalesym <= Scalein;
		Symbolreg <= Symbol;
	end
	if(ld_add) begin
		AddressLower <= {Symbolreg, {2{3'b0}}};
		AddressUpper <= {Symbolreg, {2{3'b111}}};
	end
	if (ld_romadd) Address <= AddressLower;
	if (add_enable) begin 
		Address <= Address +1;
	end
	if (updateinc) begin
		incX <= Scalesym * Address[2:0];
		incY <= Scalesym * Address[5:3];
	end
	if (updateloc) begin
		Xsym <= X + incX;
		Ysym <= Y + incY;
	end
	if (Address == AddressUpper) done = 1'b1;
	else done = 1'b0;
	
	if (pixel) Clrsym <= Clr;
	else Clrsym <= 3'b0;
	
end


endmodule
