
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w32,w31,w496,w497,w31808;

  assign w1 = i_data0;
  assign w31 = w32-w1;
  assign w31808 = (1<<1**6)*w497;
  assign w32 = w1<<5;
  assign w496 = (1<<1**4)*w31;
  assign w497 = w496+w1;
  assign o_data0 = w31808;
endmodule

