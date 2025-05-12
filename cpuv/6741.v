module  fpconv_altbarrel_shift_kof
	(
	aclr,
	clk_en,
	clock,
	data,
	distance,
	result) ;
	input   aclr;
	input   clk_en;
	input   clock;
	input   [53:0]  data;
	input   [5:0]  distance;
	output   [53:0]  result;
`ifndef ALTERA_RESERVED_QIS
`endif
	tri0   aclr;
	tri1   clk_en;
	tri0   clock;
`ifndef ALTERA_RESERVED_QIS
`endif
	reg	[1:0]	dir_pipe;
	reg	[53:0]	sbit_piper1d;
	reg	[53:0]	sbit_piper2d;
	reg	sel_pipec3r1d;
	reg	sel_pipec4r1d;
	reg	sel_pipec5r1d;
	wire  [6:0]  dir_w;
	wire  direction_w;
	wire  [31:0]  pad_w;
	wire  [377:0]  sbit_w;
	wire  [5:0]  sel_w;
	wire  [323:0]  smux_w;
	initial
		dir_pipe = 0;
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) dir_pipe <= 2'b0;
		else if  (clk_en == 1'b1)   dir_pipe <= {dir_w[5], dir_w[2]};
	initial
		sbit_piper1d = 0;
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sbit_piper1d <= 54'b0;
		else if  (clk_en == 1'b1)   sbit_piper1d <= smux_w[161:108];
	initial
		sbit_piper2d = 0;
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sbit_piper2d <= 54'b0;
		else if  (clk_en == 1'b1)   sbit_piper2d <= smux_w[323:270];
	initial
		sel_pipec3r1d = 0;
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sel_pipec3r1d <= 1'b0;
		else if  (clk_en == 1'b1)   sel_pipec3r1d <= distance[3];
	initial
		sel_pipec4r1d = 0;
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sel_pipec4r1d <= 1'b0;
		else if  (clk_en == 1'b1)   sel_pipec4r1d <= distance[4];
	initial
		sel_pipec5r1d = 0;
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sel_pipec5r1d <= 1'b0;
		else if  (clk_en == 1'b1)   sel_pipec5r1d <= distance[5];
	assign
		dir_w = {dir_pipe[1], dir_w[4:3], dir_pipe[0], dir_w[1:0], direction_w},
		direction_w = 1'b0,
		pad_w = {32{1'b0}},
		result = sbit_w[377:324],
		sbit_w = {sbit_piper2d, smux_w[269:162], sbit_piper1d, smux_w[107:0], data},
		sel_w = {sel_pipec5r1d, sel_pipec4r1d, sel_pipec3r1d, distance[2:0]},
		smux_w = {((({54{(sel_w[5] & (~ dir_w[5]))}} & {sbit_w[291:270], pad_w[31:0]}) | ({54{(sel_w[5] & dir_w[5])}} & {pad_w[31:0], sbit_w[323:302]})) | ({54{(~ sel_w[5])}} & sbit_w[323:270])), ((({54{(sel_w[4] & (~ dir_w[4]))}} & {sbit_w[253:216], pad_w[15:0]}) | ({54{(sel_w[4] & dir_w[4])}} & {pad_w[15:0], sbit_w[269:232]})) | ({54{(~ sel_w[4])}} & sbit_w[269:216])), ((({54{(sel_w[3] & (~ dir_w[3]))}} & {sbit_w[207:162], pad_w[7:0]}) | ({54{(sel_w[3] & dir_w[3])}} & {pad_w[7:0], sbit_w[215:170]})) | ({54{(~ sel_w[3])}} & sbit_w[215:162])), ((({54{(sel_w[2] & (~ dir_w[2]))}} & {sbit_w[157:108], pad_w[3:0]}) | ({54{(sel_w[2] & dir_w[2])}} & {pad_w[3:0], sbit_w[161:112]})) | ({54{(~ sel_w[2])}} & sbit_w[161:108])), ((({54{(sel_w[1] & (~ dir_w[1]))}} & {sbit_w[105:54], pad_w[1:0]}) | ({54{(sel_w[1] & dir_w[1])}} & {pad_w[1:0], sbit_w[107:56]})) | ({54{(~ sel_w[1])}} & sbit_w[107:54])), ((({54{(sel_w[0] & (~ dir_w[0]))}} & {sbit_w[52:0], pad_w[0]}) | ({54{(sel_w[0] & dir_w[0])}} & {pad_w[0], sbit_w[53:1]})) | ({54{(~ sel_w[0])}} & sbit_w[53:0]))};
endmodule