
module bigram(address_a,address_b,data_a,data_b,inclock,outclock,wren_a,
              wren_b,q_a,q_b);

  input  [16:0] address_a;
  input  [16:0] address_b;
  input  [2:0] data_a;
  input  [2:0] data_b;
  input  inclock;
  input  outclock;
  input  wren_a;
  input  wren_b;
  output [2:0] q_a;
  output [2:0] q_b;
  tri1 inclock;
  tri0 wren_a;
  tri0 wren_b;


endmodule

