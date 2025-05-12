module I8080_Controller#(
	I8080_BUS_WIDTH = 32 
	)(
	clk, 
	reset_n, 
	s_chipselect_n, 
	s_write_n, 
	s_writedata, 
	s_address, 
	i8080_cs, 
	i8080_rs, 
	i8080_rd, 
	i8080_wr, 
	i8080_data, 
);
input	clk; 
input	reset_n; 
input		    s_chipselect_n; 
input			s_write_n; 
input	    [31:0]	s_writedata; 
input	    [2:0]   	s_address; 
output	   	i8080_cs; 
output	   	i8080_rs; 
output		i8080_rd; 
output		i8080_wr; 
output	    [31:0]	i8080_data; 
assign i8080_cs = s_chipselect_n; 
assign i8080_rs = s_address[2]; 
assign i8080_rd = 1'b1; 
assign i8080_wr = s_write_n; 
assign i8080_data = s_writedata[31:0]; 
endmodule