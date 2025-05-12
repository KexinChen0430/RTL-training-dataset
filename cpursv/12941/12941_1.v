
module retorno_reg  #(parameter  WIDTH = 10)
  (input  wire swe,
   input  wire reset,
   input  wire [(-1)+WIDTH:0] d,
   output reg [(-1)+WIDTH:0] q);

  
  always @(posedge swe or posedge reset)
      if (reset) q <= 0;
      else q <= d;
endmodule

