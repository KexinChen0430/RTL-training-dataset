
module MUX2  #(parameter  SIZE = 8)
  (input  wire select,
   input  wire [(-1)+SIZE:0] inA,
   input  wire [(-1)+SIZE:0] inB,
   output reg [(-1)+SIZE:0] out);

  
  always @(*)
      begin
        out <= (select == 0) ? inA : inB;
      end
endmodule

