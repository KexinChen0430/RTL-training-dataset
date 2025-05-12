
module ALU  #(parameter  WIDTH = 32)
  (input  wire [3:0] op,
   input  wire [(-1)+WIDTH:0] inA,
   input  wire [(-1)+WIDTH:0] inB,
   output reg [(-1)+WIDTH:0] out,
   output wire zero);

  
  always @(op or inA or inB)
      begin
        case (op)

          0: out = inB & inA;

          1: out = inB | inA;

          1<<1: out = inB+inA;

          6: out = inA-inB;

          7: out = (inA < inB) ? 1 : 0;

          12: out = ~(inB | inA);

          default: out = 32'bx;

        endcase

      end
  assign zero = out == 0;
endmodule

