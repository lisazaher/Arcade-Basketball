module boxdrawer_dp(clk, reset, set, resetX, x_en, y_en, Xin, Yin, CLRin, Scalein, go, Xout, Yout, CLRout, counterX, counterY, x_done, y_done, scaleReal, setx, sety);
input clk, reset,set, resetX, x_en, y_en, setx,sety;
input [7:0] Xin;
input [6:0] Yin;
input [2:0] CLRin;
input [5:0] Scalein;
input go;
output reg [7:0] Xout;
output reg[6:0] Yout;
output reg [2:0] CLRout;
output reg [5:0] scaleReal;
//y_done is donebox
output reg  x_done, y_done;

//inside stuff
output reg [2:0] counterX, counterY;


always@(posedge clk) begin
	//the x and y are the values of the initial point + the counter
	
	
	scaleReal <= Scalein - 3'b1;
	if(!reset) begin 
		counterX <= 3'b0;
		counterY <= 3'b0;
		//scaleReal <= Scalein;
		
		x_done <= 1'b0;
		y_done <= 1'b0;
	end
	if (set) begin
		Xout <= Xin;
		Yout <= Yin;
		CLRout <= CLRin;
		counterX <= 3'b0;
		counterY <= 3'b0;
	end
	if (x_en) begin 
		counterX <= counterX +1;
		y_done <= 1'b0;
	end
	if (y_en) counterY <= counterY +1;
	if(setx)  Xout <= Xin +counterX;
	if (sety) Yout <= Yin + counterY;
	if (resetX) counterX <= 3'b0;
	if (counterX == scaleReal) x_done <= 1'b1;
	else x_done <= 1'b0;
	if (counterY == scaleReal & counterX == scaleReal) y_done <= 1'b1;
end	


endmodule
