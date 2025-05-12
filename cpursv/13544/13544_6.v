
module techlib_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [WIDTH+(-1):0] A,B,C;
  output [WIDTH+(-1):0] X,Y;
  wire [WIDTH+(-1):0] t1,t2,t3;

  assign t1 = ((~A & (A | B)) & B) | (A & (~A | ~B)),
         t2 = A & B,
         t3 = t1 & C;
  assign Y = ((t1 & (~C | C)) & (~t1 | t1)) ^ ((~t1 | t1) & C);
  assign X = ((t2 | Y) | t3) & ((~Y & ~(t2 | t3)) | (t2 | t3));
endmodule

