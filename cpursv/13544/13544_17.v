
module techlib_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [WIDTH+(-1):0] A,B,C;
  output [WIDTH+(-1):0] X,Y;
  wire [WIDTH+(-1):0] t1,t2,t3;

  assign t1 = (~(((~B | ~A) & (A & (~B | B))) & (~B | B)) & (((~B | ~A) & B) & (~B | B))) | ((((~B | ~A) & (A & (~B | B))) & (~B | B)) & ~(((~B | ~A) & B) & (~B | B))),
         t2 = A & B,
         t3 = C & t1;
  assign Y = (~C & (C | t1)) | (C & ~t1);
  assign X = (((Y & (t2 | (t3 | ~Y))) ^ (Y & (t2 | (t3 | ~Y)))) & (Y & ~(t2 | t3))) | (t2 | t3);
endmodule

