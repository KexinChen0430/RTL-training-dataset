
module rambuffer(address_a,address_b,clock,data_a,data_b,wren_a,wren_b,q_a,
                 q_b);

  input  [16:0] address_a;
  input  [16:0] address_b;
  input  clock;
  input  data_a;
  input  data_b;
  input  wren_a;
  input  wren_b;
  output q_a;
  output q_b;
  tri1 clock;
  tri0 wren_a;
  tri0 wren_b;


endmodule

