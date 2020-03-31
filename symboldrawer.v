module symboldrawer(clk, reset, Xgl, Ygl, CLRgl, Symbolgl, Scalegl, go, done, Xsym, Ysym, CLRsym, Scalesym, gobox, donebox, addEnable);
//gl is game logic
// go and done are symbol signals

//module input and output
input [7:0] Xgl;
input [6:0] Ygl;
input [2:0] CLRgl, Scalegl;
input [5:0] Symbolgl;
input clk, reset, go, donebox;


output [7:0] Xsym;
output [6:0] Ysym;
output [2:0] CLRsym;
output [5:0] Scalesym;
output gobox, done, addEnable;

//signals bw dp and ctrl
wire ld_init, ld_add, ld_romadd, add_enable, updateloc, updateinc, test;

assign addEnable = add_enable;
symboldrawer_datapath symdp(.clk(clk), 
										.reset(reset), 
										.Xin(Xgl), 
										.Yin(Ygl), 
										.Clrin(CLRgl), 
										.Scalein(Scalegl), 
										.Symbol(Symbolgl), 
										.Clrsym(CLRsym), 
										.Xsym(Xsym), 
										.Ysym(Ysym),  
										.donebox(donebox), 
										.go(go), 
										.done(done), 
										.ld_ini(ld_init), 
										.ld_add(ld_add), 
										.ld_romadd(ld_romadd), 
										.add_enable(add_enable),
										.Scalesym(Scalesym),
			.updateloc(updateloc) , .updateinc(updateinc)
										);

										
symboldrawer_ctrl symc(.clk(clk), 
						.reset(reset), 
						.go(go), 
						.gobox(gobox), 
						.donebox(donebox), 
						.done(done), 
						.ld_init(ld_init), 
						.ld_add(ld_add), 
						.ld_addrom(ld_romadd), 
						.add_enable(add_enable),
.updateloc(updateloc), .updateinc(updateinc)
						);

endmodule
