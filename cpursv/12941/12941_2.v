
module retorno_reg  #(parameter  WIDTH = 10)
  (input  wire swe,
   input  wire reset,
   input  wire [WIDTH+(0-1):0] d,
   output reg [WIDTH+(0-1):0] q);

  
  always @(posedge swe or posedge reset)
      if (reset) q <= 0;
      else q <= d;
endmodule

