
module ALU  #(parameter  WIDTH = 32)
  (input  wire [3:0] op,
   input  wire [WIDTH-1:0] inA,
   input  wire [WIDTH-1:0] inB,
   output reg [WIDTH-1:0] out,
   output wire zero);

  
  always @(op or inA or inB)
      begin
        case (op)

          0: out = inA & inB;

          1: out = inB | inA;

          2: out = inB+inA;

          6: out = inA-inB;

          7: out = (inA < inB) ? 1 : 0;

          12: out = ~(inB | inA);

          default: out = 32'bx;

        endcase

      end
  assign zero = out == 0;
endmodule

