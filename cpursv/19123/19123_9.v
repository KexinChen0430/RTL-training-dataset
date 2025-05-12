
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w32,w31,w496,w497,w31808;

  assign w1 = i_data0;
  assign w31 = (0-w1)+w32;
  assign w31808 = w497*(1<<1**6);
  assign w32 = w1<<5;
  assign w496 = (1<<1**4)*w31;
  assign w497 = w1+w496;
  assign o_data0 = w31808;
endmodule

