module drawMod (input clk, reset, go, input [5:0] symbolIn, input [2:0] scaleIn, input[7:0]XLoc, input [6:0]YLoc, output donesym, plot, output [7:0] xvga, output [6:0] yvga, output [2:0] clrvga);
	wire [7:0]xsym;
	wire [6:0]ysym;
	wire [5:0]scalesym;
	wire [2:0]clrsym;
	wire gobox, donebox, addenable;
	

	symboldrawer sym(.clk(clk), 
							.reset(reset), 
							.Xgl(XLoc), //change it to base spot for testing
							.Ygl(YLoc), //change it to base spot for teseting
							.CLRgl(3'b111), //change
							.Symbolgl(symbolIn), //change
							.Scalegl(scaleIn), 
							.go(go), 
							.done(donesym), 
							.Xsym(xsym), 
							.Ysym(ysym), 
							.CLRsym(clrsym), 
							.Scalesym(scalesym), 
							.gobox(gobox), 
							.donebox(donebox),
							.addEnable(addEnable)
							);
							
	//make box drawer

	boxdrawer box(.clk(clk), 
						.reset(reset), 
						.Xsym(xsym), 
						.Ysym(ysym), 
						.CLRsym(clrsym), 
						.Scalesym(scalesym), 
						.go(gobox), 
						.done(donebox), 
						.Xvga(xvga), 
						.Yvga(yvga), 
						.CLRvga(clrvga), 
						.plot(plot)
						);
endmodule