
module raminout2(address_a,address_b,clock,data_a,data_b,wren_a,wren_b,q_a,
                 q_b);

  input  [9:0] address_a;
  input  [9:0] address_b;
  input  clock;
  input  [31:0] data_a;
  input  [31:0] data_b;
  input  wren_a;
  input  wren_b;
  output [31:0] q_a;
  output [31:0] q_b;
  tri1 clock;
  tri0 wren_a;
  tri0 wren_b;


endmodule

