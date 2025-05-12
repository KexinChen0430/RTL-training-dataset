
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w32,w31,w496,w527,w62,w589,w18848;

  assign w1 = i_data0;
  assign w18848 = (1<<1**5)*w589;
  assign w31 = w32-w1;
  assign w32 = (1<<1**5)*w1;
  assign w496 = w31<<4;
  assign w527 = w496+w31;
  assign w589 = w527+w62;
  assign w62 = 1<<1*w31;
  assign o_data0 = w18848;
endmodule

