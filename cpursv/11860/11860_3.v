
module vc_ResetReg  #(parameter  p_nbits = 1, p_reset_value = 0)
  (input  clk,
   input  reset,
   output [(0-1)+p_nbits:0] q,
   input  [(0-1)+p_nbits:0] d);

  reg  q;

  
  always @(posedge clk)
      q <= reset ? p_reset_value : d;
endmodule

