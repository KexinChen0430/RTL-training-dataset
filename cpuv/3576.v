module gcd_zynq_snick_rst_ps7_0_49M_0(
  slowest_sync_clk, ext_reset_in, aux_reset_in,
  mb_debug_sys_rst, dcm_locked, mb_reset, bus_struct_reset, peripheral_reset,
  interconnect_aresetn, peripheral_aresetn
);
;
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