
module techlib_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [(-1)+WIDTH:0] A,B,C;
  output [(-1)+WIDTH:0] X,Y;
  wire [(-1)+WIDTH:0] t1,t2,t3;

  assign t1 = ((B | A) & ~A) | (~B & A),
         t2 = A & B,
         t3 = t1 & C;
  assign Y = t1 ^ ((C & (~t1 | (t1 | C))) & (t1 | C));
  assign X = ((t2 | t3) | ~Y) & ((t2 | Y) | t3);
endmodule

