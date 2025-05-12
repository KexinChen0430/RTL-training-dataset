
module mux4to1  #(parameter  WIDTH = 1)
  (input  wire [WIDTH+(0-1):0] inA,
   input  wire [WIDTH+(0-1):0] inB,
   input  wire [WIDTH+(0-1):0] inC,
   input  wire [WIDTH+(0-1):0] inD,
   input  wire [1:0] select,
   output reg [WIDTH+(0-1):0] out);

  
  always @(inA or inB or inC or inD or select)
      begin
        case (select)

          0: out = inA;

          1: out = inB;

          1<<<1: out = inC;

          3: out = inD;

          default: out = inA;

        endcase

      end
endmodule

