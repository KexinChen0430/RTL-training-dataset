
module multiply  #(parameter  WIDTH = 1)
  (input  [WIDTH-1:0] a,
   input  [WIDTH-1:0] b,
   output [(WIDTH*2)-1:0] out);

  assign out = a*b;
endmodule

