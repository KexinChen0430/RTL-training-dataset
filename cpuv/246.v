  input slowest_sync_clk;       
  input ext_reset_in;           
  input aux_reset_in;           
  input mb_debug_sys_rst;       
  input dcm_locked;             
  output mb_reset;              
  output [0:0] bus_struct_reset; 
  output [0:0] peripheral_reset; 
  output [0:0] interconnect_aresetn; 
  output [0:0] peripheral_aresetn;   
endmodule