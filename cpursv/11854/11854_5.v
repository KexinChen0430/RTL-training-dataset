
module vc_Reg  #(parameter  p_nbits = 1)
  (input  clk,
   output [(-1)+p_nbits:0] q,
   input  [(-1)+p_nbits:0] d);

  reg  q;

  
  always @(posedge clk)  q <= d;
endmodule

