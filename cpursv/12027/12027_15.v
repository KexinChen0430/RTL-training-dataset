
module MultiplyState(input  [32:0] aout_Special,
                     input  [32:0] bout_Special,
                     input  [35:0] cout_Special,
                     input  [35:0] zout_Special,
                     input  [31:0] sout_Special,
                     input  [1:0] modeout_Special,
                     input  operationout_Special,
                     input  NatLogFlagout_Special,
                     input  [7:0] InsTag_Special,
                     input  clock,
                     input  [1:0] idle_Special,
                     output reg [1:0] idle_Multiply,
                     output reg [35:0] cout_Multiply,
                     output reg [35:0] zout_Multiply,
                     output reg [31:0] sout_Multiply,
                     output reg [1:0] modeout_Multiply,
                     output reg operationout_Multiply,
                     output reg NatLogFlagout_Multiply,
                     output reg [49:0] productout_Multiply,
                     output reg [7:0] InsTag_Multiply);

  parameter 
       mode_circular   = 2'b01,
       mode_linear     = 2'b00,
       mode_hyperbolic = 2'b11;
  parameter 
       no_idle     = 2'b00,
       allign_idle = 2'b01,
       put_idle    = 2'b10;
  wire a_sign;
  wire [7:0] a_exponent;
  wire [23:0] a_mantissa;
  wire b_sign;
  wire [7:0] b_exponent;
  wire [23:0] b_mantissa;

  assign a_sign = aout_Special[32];
  assign a_exponent = aout_Special[31:24]+(-127);
  assign a_mantissa = {aout_Special[23:0]};
  assign b_sign = bout_Special[32];
  assign b_exponent = (-127)+bout_Special[31:24];
  assign b_mantissa = {bout_Special[23:0]};
  
  always @(posedge clock)
      begin
        InsTag_Multiply <= InsTag_Special;
        sout_Multiply <= sout_Special;
        cout_Multiply <= cout_Special;
        modeout_Multiply <= modeout_Special;
        operationout_Multiply <= operationout_Special;
        idle_Multiply <= idle_Special;
        NatLogFlagout_Multiply <= NatLogFlagout_Special;
        if (idle_Special == no_idle) 
          begin
            if (modeout_Special == mode_circular) 
              begin
                zout_Multiply[35] <= (((~a_sign | a_sign) | (((a_sign & (~b_sign | b_sign)) & ~a_sign) | ((~a_sign & (b_sign & ((~a_sign | a_sign) & b_sign))) ^ ((b_sign & a_sign) & ~a_sign)))) & (((~a_sign | a_sign) | (((a_sign & (~b_sign | b_sign)) & ~a_sign) | ((~a_sign & (b_sign & ((~a_sign | a_sign) & b_sign))) ^ ((b_sign & a_sign) & ~a_sign)))) & ((~a_sign | a_sign) & b_sign))) ^ ((a_sign & ((~a_sign | a_sign) | (((a_sign & (~b_sign | b_sign)) & ~a_sign) | ((~a_sign & (b_sign & ((~a_sign | a_sign) & b_sign))) ^ ((b_sign & a_sign) & ~a_sign))))) & ((~a_sign | a_sign) | (((a_sign & (~b_sign | b_sign)) & ~a_sign) | ((~a_sign & (b_sign & ((~a_sign | a_sign) & b_sign))) ^ ((b_sign & a_sign) & ~a_sign)))));
              end
            else if (modeout_Special == mode_hyperbolic) 
              begin
                zout_Multiply[35] <= ~((((~a_sign | a_sign) | (((a_sign & (~b_sign | b_sign)) & ~a_sign) | ((~a_sign & (b_sign & ((~a_sign | a_sign) & b_sign))) ^ ((b_sign & a_sign) & ~a_sign)))) & (((~a_sign | a_sign) | (((a_sign & (~b_sign | b_sign)) & ~a_sign) | ((~a_sign & (b_sign & ((~a_sign | a_sign) & b_sign))) ^ ((b_sign & a_sign) & ~a_sign)))) & ((~a_sign | a_sign) & b_sign))) ^ ((a_sign & ((~a_sign | a_sign) | (((a_sign & (~b_sign | b_sign)) & ~a_sign) | ((~a_sign & (b_sign & ((~a_sign | a_sign) & b_sign))) ^ ((b_sign & a_sign) & ~a_sign))))) & ((~a_sign | a_sign) | (((a_sign & (~b_sign | b_sign)) & ~a_sign) | ((~a_sign & (b_sign & ((~a_sign | a_sign) & b_sign))) ^ ((b_sign & a_sign) & ~a_sign))))));
              end
              
            zout_Multiply[34:27] <= (1+a_exponent)+b_exponent;
            zout_Multiply[26:0] <= 0;
            productout_Multiply <= b_mantissa*(4*a_mantissa);
          end
        else 
          begin
            zout_Multiply <= zout_Special;
          end
      end
endmodule

