module boxdrawer(clk, reset, Xsym, Ysym, CLRsym, Scalesym, go, done, Xvga, Yvga, CLRvga, plot);
input clk, reset, go;
input [7:0] Xsym;
input [6:0] Ysym;
input [2:0] CLRsym;
input [5:0] Scalesym;
output [7:0] Xvga;
output [6:0] Yvga;
output [2:0] CLRvga;
output plot, done;

//stuff going between control and datapath
wire x_done, y_done, x_en, y_en, resetx, set, setx, sety;
wire [2:0] dummycx, dummyyx;
wire [5:0] dummyScale;

boxdrawer_dp boxdp(.clk(clk), 
						.reset(reset), 
						.set(set), 
						.resetX(resetx), 
						.x_en(x_en), 
						.y_en(y_en),
						.Xin(Xsym),
						.Yin(Ysym),
						.CLRin(CLRsym),
						.Scalein(Scalesym),
						.go(go),
						.Xout(Xvga),
						.Yout(Yvga),
						.CLRout(CLRvga),
						.x_done(x_done), 
						.y_done(y_done), 
						.scaleReal(dummyScale),
						.counterX(dummycx),
						.counterY(dummyyx),
.setx(setx), .sety(sety)
						);
						
boxdrawer_ctrl bdc(.clk(clk), 
						.go(go),
						.x_done(x_done), 
						.y_done(y_done),
						.reset(reset),
						.set(set), 
						.x_en(x_en), 
						.y_en(y_en), 
						.resetx(resetx), 
						.plot(plot),
						.done(done),
.setx(setx), .sety(sety)
						);


endmodule 
//plot only goes to control
//reset coming from button, coming from higherlevel