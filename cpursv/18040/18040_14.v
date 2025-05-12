
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w32,w31,w124,w125,w2000,w1999,w7996,w9995;

  assign w1 = i_data0;
  assign w124 = w31<<1*1<<1;
  assign w125 = w1+w124;
  assign w1999 = (-w1)+w2000;
  assign w2000 = w125*(1<<1**4);
  assign w31 = w32+(-w1);
  assign w32 = (1<<1**5)*w1;
  assign w7996 = w1999<<<1<<1;
  assign w9995 = w1999+w7996;
  assign o_data0 = w9995;
endmodule

