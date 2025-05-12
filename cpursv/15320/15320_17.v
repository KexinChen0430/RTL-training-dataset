
module qmult  #(parameter  Q = 15, N = 32)
  (input  [(-1)+N:0] i_multiplicand,
   input  [(-1)+N:0] i_multiplier,
   output [(-1)+N:0] o_result,
   output reg ovr);

  reg  [(2*N)+(-1):0] r_result;
  reg  [(-1)+N:0] r_RetVal;

  assign o_result = r_RetVal;
  
  always @(i_multiplicand or i_multiplier)
      begin
        r_result <= i_multiplier[(0-2)+N:0]*i_multiplicand[(0-2)+N:0];
      end
  
  always @(r_result)
      begin
        r_RetVal[(-1)+N] <= i_multiplicand[(-1)+N] ^ i_multiplier[(-1)+N];
        r_RetVal[(0-2)+N:0] <= r_result[((0-2)+N)+Q:Q];
        if (r_result[(2*N)-2:(-1)+(Q+N)] > 0) ovr <= 1'b1;
        else ovr <= 1'b0;
      end
endmodule

