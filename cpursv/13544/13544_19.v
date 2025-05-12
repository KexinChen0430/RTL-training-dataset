
module techlib_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [(-1)+WIDTH:0] A,B,C;
  output [(-1)+WIDTH:0] X,Y;
  wire [(-1)+WIDTH:0] t1,t2,t3;

  assign t1 = (~((~B | ~A) & B) & ((((~B | B) & A) & (~B | ~A)) & (~A | A))) | (((~B | ~A) & B) & ~((((~B | B) & A) & (~B | ~A)) & (~A | A))),
         t2 = A & B,
         t3 = C & t1;
  assign Y = C ^ t1;
  assign X = t2 | ((Y ^ Y) | t3);
endmodule

