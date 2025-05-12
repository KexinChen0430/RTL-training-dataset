
module ded_ca_top  #(parameter  BYTES = 4)
  (input  mclock,
   input  mc_push,
   input  hclock,
   input  hb_we,
   input  [4:0] hb_addr,
   input  [(8*BYTES)-1:0] hb_dout_ram,
   output [31:0] hb_dout,
   output [4:0] hb_ram_addr,
   output [4:0] ca_ram_addr0,
   output [4:0] ca_ram_addr1);

  wire [4:0] radp1;

  assign radp1 = rad+1;
  assign hb_dout = hb_dout_ram[31:0];
  assign ca_enable = hb_we;
  assign hb_ram_addr = hb_addr[4:0];
  assign ca_ram_addr0 = mc_push ? mc_addr : rad;
  assign ca_ram_addr1 = mc_push ? mc_addr : radp1;
endmodule

