
module alu(input  [31:0] A,B,
           input  [1<<1:0] F,
           output reg [31:0] Y,
           output Zero);

  
  always @(*)
      case (F[1<<1:0])

        3'b000: Y <= B & A;

        3'b001: Y <= A | B;

        3'b010: Y <= A+B;

        3'b011: Y <= A & ~B;

        3'b101: Y <= ~B+A;

        3'b110: Y <= (0-B)+A;

        3'b111: Y <= (A < B) ? 1 : 0;

        default: Y <= 0;

      endcase

  assign Zero = Y == 32'b0;
endmodule

