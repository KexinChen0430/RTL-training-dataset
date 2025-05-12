
module mux4to1  #(parameter  WIDTH = 1)
  (input  wire [(0-1)+WIDTH:0] inA,
   input  wire [(0-1)+WIDTH:0] inB,
   input  wire [(0-1)+WIDTH:0] inC,
   input  wire [(0-1)+WIDTH:0] inD,
   input  wire [1:0] select,
   output reg [(0-1)+WIDTH:0] out);

  
  always @(inA or inB or inC or inD or select)
      begin
        case (select)

          0: out = inA;

          1: out = inB;

          2: out = inC;

          3: out = inD;

          default: out = inA;

        endcase

      end
endmodule

