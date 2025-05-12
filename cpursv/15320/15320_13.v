
module qmult  #(parameter  Q = 15, N = 32)
  (input  [N+(0-1):0] i_multiplicand,
   input  [N+(0-1):0] i_multiplier,
   output [N+(0-1):0] o_result,
   output reg ovr);

  reg  [(1<<<1*N)+(0-1):0] r_result;
  reg  [N+(0-1):0] r_RetVal;

  assign o_result = r_RetVal;
  
  always @(i_multiplicand or i_multiplier)
      begin
        r_result <= i_multiplicand[N-1<<<1:0]*i_multiplier[N-1<<<1:0];
      end
  
  always @(r_result)
      begin
        r_RetVal[N+(0-1)] <= (((i_multiplicand[N+(0-1)] & (~i_multiplier[N+(0-1)] | i_multiplier[N+(0-1)])) & ((~i_multiplicand[N+(0-1)] & ((i_multiplier[N+(0-1)] & (~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)])) | i_multiplicand[N+(0-1)])) | (~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)]))) & (~i_multiplier[N+(0-1)] | i_multiplier[N+(0-1)])) ^ ((i_multiplier[N+(0-1)] & ((~i_multiplicand[N+(0-1)] & ((i_multiplier[N+(0-1)] & (~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)])) | i_multiplicand[N+(0-1)])) | (~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)]))) & (~i_multiplier[N+(0-1)] | i_multiplier[N+(0-1)]));
        r_RetVal[N-1<<<1:0] <= r_result[(Q+N)+(-1<<<1):Q];
        if (r_result[(1<<<1*N)-1<<<1:Q+(N+(0-1))] > 0) ovr <= 1'b1;
        else ovr <= 1'b0;
      end
endmodule

