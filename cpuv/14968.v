module e203_subsys_hclkgen_rstsync (
  input  clk,        
  input  rst_n_a,    
  input  test_mode,  
  output rst_n       
);
localparam RST_SYNC_LEVEL = `E203_ASYNC_FF_LEVELS; 
reg [RST_SYNC_LEVEL-1:0] rst_sync_r; 
always @(posedge clk or negedge rst_n_a)
begin:rst_sync_PROC
  if(rst_n_a == 1'b0) 
    begin
      rst_sync_r[RST_SYNC_LEVEL-1:0] <= {RST_SYNC_LEVEL{1'b0}}; 
    end
  else 
    begin
      rst_sync_r[RST_SYNC_LEVEL-1:0] <= {rst_sync_r[RST_SYNC_LEVEL-2:0],1'b1}; 
    end
end
assign rst_n = test_mode ? rst_n_a : rst_sync_r[`E203_ASYNC_FF_LEVELS-1];
endmodule