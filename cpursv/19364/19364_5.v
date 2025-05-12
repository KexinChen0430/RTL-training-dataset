
module MUX2  #(parameter  SIZE = 8)
  (input  wire select,
   input  wire [SIZE+(0-1):0] inA,
   input  wire [SIZE+(0-1):0] inB,
   output reg [SIZE+(0-1):0] out);

  
  always @(*)
      begin
        out <= (select == 0) ? inA : inB;
      end
endmodule

