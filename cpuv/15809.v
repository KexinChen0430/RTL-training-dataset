module daala_4x4_transpose_v1_0 # 
(
	parameter integer C_S00_AXIS_TDATA_WIDTH	= 256, 
	parameter integer C_M00_AXIS_TDATA_WIDTH	= 256 
)
(
    input wire axis_clk, 
    input wire axis_aresetn, 
	output wire  s00_axis_tready, 
	input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata, 
	input wire  s00_axis_tlast, 
	input wire  s00_axis_tvalid, 
	output wire  m00_axis_tvalid, 
	output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata, 
	output wire  m00_axis_tlast, 
	input wire  m00_axis_tready 
);
assign s00_axis_tready = m00_axis_tready; 
assign m00_axis_tlast = s00_axis_tlast; 
assign m00_axis_tvalid = s00_axis_tvalid; 
assign m00_axis_tdata[( 0+1)*16-1: 0*16] = s00_axis_tdata[( 0+1)*16-1: 0*16]; 
assign m00_axis_tdata[( 1+1)*16-1: 1*16] = s00_axis_tdata[( 4+1)*16-1: 4*16]; 
assign m00_axis_tdata[( 2+1)*16-1: 2*16] = s00_axis_tdata[( 8+1)*16-1: 8*16]; 
assign m00_axis_tdata[( 3+1)*16-1: 3*16] = s00_axis_tdata[(12+1)*16-1:12*16]; 
endmodule 