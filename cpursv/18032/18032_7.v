
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w32,w31,w16384,w16353,w8192,w24545,w496,w25041;

  assign w1 = i_data0;
  assign w16353 = w16384-w31;
  assign w16384 = w1*(2**14);
  assign w24545 = w8192+w16353;
  assign w25041 = w496+w24545;
  assign w31 = (0-w1)+w32;
  assign w32 = w1*(2**5);
  assign w496 = w31*(2**4);
  assign w8192 = (2**13)*w1;
  assign o_data0 = w25041;
endmodule

