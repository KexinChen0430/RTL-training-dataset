
module adder  #(parameter  WIDTH = 1)
  (input  [(0-1)+WIDTH:0] a,
   input  [(0-1)+WIDTH:0] b,
   input  cin,
   output cout,
   output [(0-1)+WIDTH:0] sumout);

  assign {cout,sumout} = (a+cin)+b;
endmodule

