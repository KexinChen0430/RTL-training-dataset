module system_rgb888_mux_2_0_0(clk, sel, rgb888_0, rgb888_1, rgb888)
;
  input clk;
  input sel;
  input [23:0]rgb888_0;
  input [23:0]rgb888_1;
  output [23:0]rgb888;
endmodule