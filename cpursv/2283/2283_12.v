
module MultiplyMult(input  [32:0] aout_Special,
                    input  [32:0] bout_Special,
                    input  [32:0] zout_Special,
                    input  idle_Special,
                    input  clock,
                    output reg idle_Multiply,
                    output reg [32:0] zout_Multiply,
                    output reg [49:0] productout_Multiply);

  parameter  no_idle = 1'b0, put_idle = 1'b1;
  wire a_sign;
  wire [7:0] a_exponent;
  wire [23:0] a_mantissa;
  wire b_sign;
  wire [7:0] b_exponent;
  wire [23:0] b_mantissa;

  assign a_sign = aout_Special[32];
  assign a_exponent = aout_Special[31:24]-127;
  assign a_mantissa = {aout_Special[23:0]};
  assign b_sign = bout_Special[32];
  assign b_exponent = bout_Special[31:24]-127;
  assign b_mantissa = {bout_Special[23:0]};
  
  always @(posedge clock)
      begin
        idle_Multiply <= idle_Special;
        if (idle_Special == no_idle) 
          begin
            zout_Multiply[32] <= ((((((~b_sign | b_sign) & a_sign) & ~a_sign) | ((~((((b_sign & a_sign) & b_sign) ^ (b_sign & ((b_sign & (a_sign | ~a_sign)) & b_sign))) & ~a_sign) & (((b_sign & ((~b_sign | b_sign) & a_sign)) ^ (((~b_sign | b_sign) & a_sign) & (b_sign & a_sign))) & ~a_sign)) | (((((b_sign & a_sign) & b_sign) ^ (b_sign & ((b_sign & (a_sign | ~a_sign)) & b_sign))) & ~a_sign) & ~(((b_sign & ((~b_sign | b_sign) & a_sign)) ^ (((~b_sign | b_sign) & a_sign) & (b_sign & a_sign))) & ~a_sign)))) | (a_sign | ~a_sign)) & ((~b_sign | b_sign) & a_sign)) ^ ((((((~b_sign | b_sign) & a_sign) & ~a_sign) | ((~((((b_sign & a_sign) & b_sign) ^ (b_sign & ((b_sign & (a_sign | ~a_sign)) & b_sign))) & ~a_sign) & (((b_sign & ((~b_sign | b_sign) & a_sign)) ^ (((~b_sign | b_sign) & a_sign) & (b_sign & a_sign))) & ~a_sign)) | (((((b_sign & a_sign) & b_sign) ^ (b_sign & ((b_sign & (a_sign | ~a_sign)) & b_sign))) & ~a_sign) & ~(((b_sign & ((~b_sign | b_sign) & a_sign)) ^ (((~b_sign | b_sign) & a_sign) & (b_sign & a_sign))) & ~a_sign)))) | (a_sign | ~a_sign)) & b_sign);
            zout_Multiply[31:24] <= (b_exponent+1)+a_exponent;
            zout_Multiply[23:0] <= 0;
            productout_Multiply <= a_mantissa*(b_mantissa*4);
          end
        else 
          begin
            zout_Multiply <= zout_Special;
          end
      end
endmodule

