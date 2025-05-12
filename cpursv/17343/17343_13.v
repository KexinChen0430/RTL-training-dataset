
module _90_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [WIDTH+(0-1):0] A,B,C;
  output [WIDTH+(0-1):0] X,Y;
  wire [WIDTH+(0-1):0] t1,t2,t3;

  assign t1 = ((A & (B | ~B)) & (B | ~B)) ^ B,
         t2 = B & A,
         t3 = t1 & C;
  assign Y = (C & ~t1) | (((C & ~t1) | t1) & ~C),
         X = t2 | t3;
endmodule

