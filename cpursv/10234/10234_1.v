
module mux2to1  #(parameter  WIDTH = 1)
  (input  wire [(-1)+WIDTH:0] inA,
   input  wire [(-1)+WIDTH:0] inB,
   input  wire select,
   output reg [(-1)+WIDTH:0] out);

  
  always @(inA or inB or select)
      begin
        case (select)

          0: out = inA;

          1: out = inB;

          default: out = inA;

        endcase

      end
endmodule

