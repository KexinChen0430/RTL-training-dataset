module feature_map_buffer_ctrl(
  input clock,                                
  input reset,                                
  input data_rdy,                             
  input [`X_COORD_BITWIDTH:0] xcoord,         
  input [`Y_COORD_BITWIDTH:0] ycoord,         
  output reg [`FM_ADDR_BITWIDTH:0] addr,      
  output reg buffer_full                      
);
always@(posedge clock or negedge reset) begin
  if(reset == 1'b0)                           
    addr <= `FM_ADDR_WIDTH'd0;                
  else if (data_rdy)                          
    if(xcoord[0] & ycoord[0])                 
       addr <= addr + `FM_ADDR_WIDTH'd1;      
    else
       addr <= addr;                          
  else
    addr <= `FM_ADDR_WIDTH'd0;                
end 
always@(posedge clock or negedge reset) begin
  if (reset == 1'b0) begin                   
    buffer_full <= 1'b0;                      
  end else begin
    if (addr == `ADDR_MAX - 1) begin          
      buffer_full <= 1'b1;                    
    end else begin
      buffer_full <= 1'b0;                    
    end 
  end 
end 
endmodule 