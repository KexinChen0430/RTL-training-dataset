
module qmult  #(parameter  Q = 15, N = 32)
  (input  [(-1)+N:0] i_multiplicand,
   input  [(-1)+N:0] i_multiplier,
   output [(-1)+N:0] o_result,
   output reg ovr);

  reg  [N<<<1+(-1):0] r_result;
  reg  [(-1)+N:0] r_RetVal;

  assign o_result = r_RetVal;
  
  always @(i_multiplicand or i_multiplier)
      begin
        r_result <= i_multiplier[N-1<<1:0]*i_multiplicand[N-1<<1:0];
        ovr <= 1'b0;
      end
  
  always @(r_result)
      begin
        r_RetVal[(-1)+N] <= i_multiplicand[(-1)+N] ^ i_multiplier[(-1)+N];
        r_RetVal[N-1<<1:0] <= r_result[(Q+N)+(-1<<1):Q];
        if (r_result[(-1<<1)+N<<<1:Q+((-1)+N)] > 0) ovr <= 1'b1;
          
      end
endmodule

