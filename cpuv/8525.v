module bw_tsr (
	vdd_tsr,
	div,
	clk,
	reset_l,
	tsel,
   	dout,
   	testio,
	i50,
	v0p5,
	vreg_selbg_l);
	input  vdd_tsr;
	input  [9:1] div;
	input  clk;
	input  reset_l;
	input  [7:0] tsel;
	input  vreg_selbg_l;
   	output [7:0] dout;
   	output [1:0] testio;
	output [7:0] i50;
	output v0p5;
endmodule