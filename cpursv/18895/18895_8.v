
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w16384,w16385,w256,w16641,w16,w16657;

  assign w1 = i_data0;
  assign w16 = (2**4)*w1;
  assign w16384 = (2**14)*w1;
  assign w16385 = w16384+w1;
  assign w16641 = w16385+w256;
  assign w16657 = w16+w16641;
  assign w256 = w1<<8;
  assign o_data0 = w16657;
endmodule

