
module techlib_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [WIDTH+(-1):0] A,B,C;
  output [WIDTH+(-1):0] X,Y;
  wire [WIDTH+(-1):0] t1,t2,t3;

  assign t1 = (B & (~A & (B | A))) | (~B & A),
         t2 = A & B,
         t3 = C & t1;
  assign Y = ((C | ~C) & ((~t1 | t1) & ((((C | t1) & ~t1) | ~C) & t1))) ^ ((C | ~C) & ((((C | t1) & ~t1) | ~C) & C));
  assign X = (t2 | t3) ^ (Y ^ Y);
endmodule

