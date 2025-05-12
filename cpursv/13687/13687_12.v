
module adder  #(parameter  WIDTH = 1)
  (input  [WIDTH-1:0] a,
   input  [WIDTH-1:0] b,
   input  cin,
   output cout,
   output [WIDTH-1:0] sumout);

  assign {cout,sumout} = (cin+a)+b;
endmodule

