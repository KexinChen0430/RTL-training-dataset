
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w32,w31,w4,w27,w13824,w13855,w27710;

  assign w1 = i_data0;
  assign w13824 = w27<<<9;
  assign w13855 = w13824+w31;
  assign w27 = w31+(0-w4);
  assign w27710 = w13855*1<<<1;
  assign w31 = (-w1)+w32;
  assign w32 = w1*1<<5;
  assign w4 = (1<<<1*1<<<1)*w1;
  assign o_data0 = w27710;
endmodule

