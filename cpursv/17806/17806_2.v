
module wb_semaphore  #(parameter  count = 8, DBUS_WIDTH = 32)
  (input  wb_clk_i,
   input  wb_rst_i,
   input  [DBUS_WIDTH+(0-1):0] wb_dat_i,
   input  [2:0] wb_adr_i,
   input  wb_cyc_i,
   input  wb_stb_i,
   input  wb_we_i,
   output wb_ack_o,
   output [DBUS_WIDTH+(0-1):0] wb_dat_o);

  reg  [count+(0-1):0] locked;

  
  always @(posedge clock)
      if (wb_rst_i) locked <= {count{1'b0}};
      else if (wb_stb_i) 
        if (wb_we_i) locked[adr_i] <= 1'b0;
        else locked[adr_i] <= 1'b1;
        
  assign wb_dat_o[DBUS_WIDTH+(0-1):1] = {DBUS_WIDTH+(0-1){1'b0}};
  assign wb_dat_o[0] = locked[adr_i];
  assign wb_ack_o = wb_stb_i;
endmodule

