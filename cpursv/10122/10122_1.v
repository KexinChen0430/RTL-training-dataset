
module bd_proc_sys_reset_1_0(slowest_sync_clk,ext_reset_in,aux_reset_in,mb_debug_sys_rst,
                             dcm_locked,mb_reset,bus_struct_reset,peripheral_reset,
                             interconnect_aresetn,peripheral_aresetn);

  input  slowest_sync_clk;
  input  ext_reset_in;
  input  aux_reset_in;
  input  mb_debug_sys_rst;
  input  dcm_locked;
  output mb_reset;
  output bus_struct_reset;
  output peripheral_reset;
  output interconnect_aresetn;
  output peripheral_aresetn;


endmodule

