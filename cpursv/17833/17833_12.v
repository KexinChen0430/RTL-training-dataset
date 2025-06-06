
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w1024,w1025,w32,w993,w128,w865,w13840,w14705;

  assign w1 = i_data0;
  assign w1024 = w1<<<10;
  assign w1025 = w1024+w1;
  assign w128 = w1*((1+1)**7);
  assign w13840 = ((1+1)**4)*w865;
  assign w14705 = w865+w13840;
  assign w32 = w1<<5;
  assign w865 = w993+(0-w128);
  assign w993 = (0-w32)+w1025;
  assign o_data0 = w14705;
endmodule

