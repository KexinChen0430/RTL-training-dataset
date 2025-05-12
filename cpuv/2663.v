module ad_axis_inf_rx (
  clk,    
  rst,    
  valid,  
  last,   
  data,   
  inf_valid,  
  inf_last,   
  inf_data,   
  inf_ready); 
parameter   DATA_WIDTH = 16; 
localparam  DW = DATA_WIDTH - 1; 
input           clk;   
input           rst;   
input           valid; 
input           last;  
input   [DW:0]  data;  
output          inf_valid; 
output          inf_last;  
output  [DW:0]  inf_data;  
input           inf_ready; 
reg     [ 2:0]  wcnt = 'd0; 
reg             wlast_0 = 'd0; 
reg     [DW:0]  wdata_0 = 'd0; 
always @(posedge clk) begin
end
always @(posedge clk) begin
end
endmodule