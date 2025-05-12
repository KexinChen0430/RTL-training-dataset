module adbg_or1k_status_reg  (
  data_i,        
  we_i,          
  tck_i,         
  bp_i,          
  rst_i,         
  cpu_clk_i,     
  ctrl_reg_o,    
  cpu_stall_o,   
  cpu_rst_o      
);
input  [`DBG_OR1K_STATUS_LEN - 1:0] data_i; 
input                               we_i;   
input                               tck_i;  
input                               bp_i;   
input                               rst_i;  
input                               cpu_clk_i; 
output [`DBG_OR1K_STATUS_LEN - 1:0] ctrl_reg_o; 
output                              cpu_stall_o; 
output                              cpu_rst_o;   
reg                                 cpu_reset; 
wire [2:1]                          cpu_op_out; 
reg                                 stall_bp, stall_bp_csff, stall_bp_tck; 
reg                                 stall_reg, stall_reg_csff, stall_reg_cpu; 
reg                                 cpu_reset_csff; 
reg                                 cpu_rst_o; 
always @ (posedge cpu_clk_i or posedge rst_i)
begin
  if(rst_i)
    stall_bp <= #1 1'b0; 
  else if(bp_i)
    stall_bp <= #1 1'b1; 
  else if(stall_reg_cpu)
    stall_bp <= #1 1'b0; 
end
always @ (posedge tck_i or posedge rst_i)
begin
  if (rst_i)
  begin
    stall_bp_csff <= #1 1'b0; 
    stall_bp_tck  <= #1 1'b0; 
  end
  else
  begin
    stall_bp_csff <= #1 stall_bp; 
    stall_bp_tck  <= #1 stall_bp_csff; 
  end
end
always @ (posedge cpu_clk_i or posedge rst_i)
begin
  if (rst_i)
  begin
    stall_reg_csff <= #1 1'b0; 
    stall_reg_cpu  <= #1 1'b0; 
  end
  else
  begin
    stall_reg_csff <= #1 stall_reg; 
    stall_reg_cpu  <= #1 stall_reg_csff; 
  end
end
assign cpu_stall_o = bp_i | stall_bp | stall_reg_cpu; 
always @ (posedge tck_i or posedge rst_i)
begin
  if (rst_i)
    stall_reg <= #1 1'b0; 
  else if (stall_bp_tck)
    stall_reg <= #1 1'b1; 
  else if (we_i)
    stall_reg <= #1 data_i[0]; 
end
always @ (posedge tck_i or posedge rst_i)
begin
  if (rst_i)
    cpu_reset  <= #1 1'b0; 
  else if(we_i)
    cpu_reset  <= #1 data_i[1]; 
end
always @ (posedge cpu_clk_i or posedge rst_i)
begin
  if (rst_i)
  begin
    cpu_reset_csff      <= #1 1'b0; 
    cpu_rst_o           <= #1 1'b0; 
  end
  else
  begin
    cpu_reset_csff      <= #1 cpu_reset; 
    cpu_rst_o           <= #1 cpu_reset_csff; 
  end
end
assign ctrl_reg_o = {cpu_reset, stall_reg}; 
endmodule 