
module alu(input  [3:0] alu_ctl,
           input  signed  [31:0] A,B,
           output zero,
           output reg [31:0] result);

  assign zero = result == 0;
  
  always @* 
      begin
        case (alu_ctl)

          4'b0001: result <= A+B;

          4'b0010: result <= A-B;

          4'b0011: result <= A & B;

          4'b0100: result <= B | A;

          4'b0101: result <= ((A & (B | ~B)) & (((~((((B & (A & B)) & ~(((B & (~A | A)) & B) & B)) | (~(B & (A & B)) & (((B & (~A | A)) & B) & B))) & (B | ~B)) & ((B | ~B) & (((A & B) & A) ^ (A & B)))) | (((((B & (A & B)) & ~(((B & (~A | A)) & B) & B)) | (~(B & (A & B)) & (((B & (~A | A)) & B) & B))) & (B | ~B)) & ~((B | ~B) & (((A & B) & A) ^ (A & B))))) | ~B)) ^ ((~((((B & (A & B)) & ~(((B & (~A | A)) & B) & B)) | (~(B & (A & B)) & (((B & (~A | A)) & B) & B))) & (B | ~B)) & ((B | ~B) & (((A & B) & A) ^ (A & B)))) | (((((B & (A & B)) & ~(((B & (~A | A)) & B) & B)) | (~(B & (A & B)) & (((B & (~A | A)) & B) & B))) & (B | ~B)) & ~((B | ~B) & (((A & B) & A) ^ (A & B)))));

          4'b0110: result <= ~(B | A);

          4'b0111: result <= B>>1;

          4'b1000: result <= {B[15:0],16'b0};

          4'b1001: result <= A < B;

          default: result <= 0;

        endcase

      end
endmodule

