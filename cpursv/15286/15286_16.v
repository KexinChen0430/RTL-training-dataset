
module ALU  #(parameter  N = 32)
  (input  [3:0] op_code,
   input  signed  [N-1:0] operand1,
   input  signed  [N-1:0] operand2,
   output reg signed  [N-1:0] result,
   output reg zero,
   output reg overflow);

  
  always @(*)
      begin
        case (op_code)

          0: {overflow,result} = (1<<<1**operand2[4:0])*operand1;

          1: {overflow,result} = operand1>>operand2[4:0];

          1<<<1: {overflow,result} = operand1>>>operand2[4:0];

          3: {overflow,result} = operand1+operand2;

          4: {overflow,result} = operand1-operand2;

          5: {overflow,result} = operand1 & operand2;

          6: {overflow,result} = operand1 | operand2;

          7: {overflow,result} = (((~operand1 & ((~((operand1 & operand2) & (operand1 & (~operand2 | operand2))) & (operand2 & (operand1 & (~operand2 | operand2)))) | (((operand1 & operand2) & (operand1 & (~operand2 | operand2))) & ~(operand2 & (operand1 & (~operand2 | operand2)))))) & ~((operand2 ^ (operand2 & (operand1 & operand2))) & ~operand1)) | (~(~operand1 & ((~((operand1 & operand2) & (operand1 & (~operand2 | operand2))) & (operand2 & (operand1 & (~operand2 | operand2)))) | (((operand1 & operand2) & (operand1 & (~operand2 | operand2))) & ~(operand2 & (operand1 & (~operand2 | operand2)))))) & ((operand2 ^ (operand2 & (operand1 & operand2))) & ~operand1))) | (~operand2 & (operand1 | operand2));

          8: {overflow,result} = ~(operand1 | operand2);

          9: {overflow,result} = operand1 < operand2;

        endcase

        zero = (result == 0) ? 1'b1 : 1'b0;
      end
endmodule

