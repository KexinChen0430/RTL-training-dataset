
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w16,w17,w136,w153,w256,w103,w3296;

  assign w1 = i_data0;
  assign w103 = (-w153)+w256;
  assign w136 = w17<<3;
  assign w153 = w136+w17;
  assign w16 = w1<<<4;
  assign w17 = w1+w16;
  assign w256 = w1*(1<<1**8);
  assign w3296 = w103<<5;
  assign o_data0 = w3296;
endmodule

