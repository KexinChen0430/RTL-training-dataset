
module qmult  #(parameter  Q = 15, N = 32)
  (input  [N-1:0] i_multiplicand,
   input  [N-1:0] i_multiplier,
   output [N-1:0] o_result,
   output reg ovr);

  reg  [N<<1+(-1):0] r_result;
  reg  [N-1:0] r_RetVal;

  assign o_result = r_RetVal;
  
  always @(i_multiplicand or i_multiplier)
      begin
        r_result <= i_multiplicand[(0-(1+1))+N:0]*i_multiplier[(0-(1+1))+N:0];
        ovr <= 1'b0;
      end
  
  always @(r_result)
      begin
        r_RetVal[N-1] <= i_multiplier[N-1] ^ ((~i_multiplier[N-1] | i_multiplier[N-1]) & i_multiplicand[N-1]);
        r_RetVal[(0-(1+1))+N:0] <= r_result[(Q+(0-(1+1)))+N:Q];
        if (r_result[N<<1+(0-(1+1)):Q+(N-1)] > 0) ovr <= 1'b1;
          
      end
endmodule

