
module Calculator_Full_Adder  #(parameter  WIDTH = 4)
  (input  [(0-1)+WIDTH:0] A,
   input  [(0-1)+WIDTH:0] B,
   input  CIN,
   output [(0-1)+WIDTH:0] RES,
   output COUT);

  wire signed  [WIDTH:0] op_a;
  wire signed  [WIDTH:0] op_b;

  assign op_a = {A[(0-1)+WIDTH],A};
  assign op_b = {B[(0-1)+WIDTH],B};
  assign {COUT,RES} = CIN+(op_a+op_b);
endmodule

