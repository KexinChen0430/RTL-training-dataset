
module vc_Reg  #(parameter  p_nbits = 1)
  (input  clk,
   output [p_nbits+(0-1):0] q,
   input  [p_nbits+(0-1):0] d);

  reg  q;

  
  always @(posedge clk)  q <= d;
endmodule

