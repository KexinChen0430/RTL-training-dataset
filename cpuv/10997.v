module T3MAPS (
	input SR_IN,           
	input DAC_LOAD,        
	input STROBE_LOAD,     
	input GLOBAL_CFG_CLK,  
	input PIXEL_CLK,       
	output PIXEL_DATA_OUT, 
	output GLOBAL_CFG_OUT  
);
reg [63:0] pixel_columns[17:0]; 
reg [175:0] global_cfg;
reg [31:0] pixel_cfg;
reg [143:0] dac_cfg;
wire [5:0] current_column;
assign current_column = pixel_cfg[5:0]; 
assign GLOBAL_CFG_OUT = global_cfg[0];
assign PIXEL_DATA_OUT = pixel_columns[current_column][0];
always @ (posedge GLOBAL_CFG_CLK, posedge DAC_LOAD, posedge STROBE_LOAD)
begin
	global_cfg = global_cfg >> 1; 
	global_cfg[175] = SR_IN;      
	if (DAC_LOAD) begin           
		dac_cfg = global_cfg[143:0]; 
	end
	if (STROBE_LOAD) begin        
		pixel_cfg = global_cfg[175:144]; 
	end
end
always @ (posedge PIXEL_CLK)
begin
	pixel_columns[current_column] = pixel_columns[current_column] >> 1; 
end
endmodule 