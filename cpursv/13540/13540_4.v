
module multiply  #(parameter  WIDTH = 1)
  (input  [WIDTH-1:0] a,
   input  [WIDTH-1:0] b,
   output [WIDTH<<<1+(-1):0] out);

  assign out = b*a;
endmodule

