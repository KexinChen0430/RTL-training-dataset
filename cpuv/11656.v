module  fpadd_altbarrel_shift_s0g
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
	input   [25:0]  data;
	input   [4:0]  distance;
	output   [25:0]  result;
`ifndef ALTERA_RESERVED_QIS
`endif
	tri0   aclr;   
	tri1   clk_en; 
	tri0   clock;  
`ifndef ALTERA_RESERVED_QIS
`endif
	reg	[1:0]	dir_pipe;  
	reg	[25:0]	sbit_piper1d; 
	reg	[25:0]	sbit_piper2d; 
	reg	sel_pipec2r1d; 
	reg	sel_pipec3r1d; 
	reg	sel_pipec4r1d; 
	reg	sel_pipec4r2d; 
	wire  [5:0]  dir_w; 
	wire  direction_w; 
	wire  [15:0]  pad_w; 
	wire  [155:0]  sbit_w; 
	wire  [4:0]  sel_w; 
	wire  [129:0]  smux_w; 
	initial dir_pipe = 0;
	initial sbit_piper1d = 0;
	initial sbit_piper2d = 0;
	initial sel_pipec2r1d = 0;
	initial sel_pipec3r1d = 0;
	initial sel_pipec4r1d = 0;
	initial sel_pipec4r2d = 0;
endmodule