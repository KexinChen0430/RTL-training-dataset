
module multiply  #(parameter  WIDTH = 1)
  (input  [(0-1)+WIDTH:0] a,
   input  [(0-1)+WIDTH:0] b,
   output [(WIDTH*(1+1))+(0-1):0] out);

  assign out = a*b;
endmodule

