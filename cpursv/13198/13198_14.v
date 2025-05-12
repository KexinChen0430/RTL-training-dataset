
module Calculator_Full_Adder  #(parameter  WIDTH = 4)
  (input  [WIDTH+(0-1):0] A,
   input  [WIDTH+(0-1):0] B,
   input  CIN,
   output [WIDTH+(0-1):0] RES,
   output COUT);

  wire signed  [WIDTH:0] op_a;
  wire signed  [WIDTH:0] op_b;

  assign op_a = {A[WIDTH+(0-1)],A};
  assign op_b = {B[WIDTH+(0-1)],B};
  assign {COUT,RES} = (op_b+op_a)+CIN;
endmodule

