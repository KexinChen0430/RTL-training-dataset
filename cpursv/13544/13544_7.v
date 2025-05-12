
module techlib_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [WIDTH-1:0] A,B,C;
  output [WIDTH-1:0] X,Y;
  wire [WIDTH-1:0] t1,t2,t3;

  assign t1 = A ^ ((~A | A) & (B & (~A | A))),
         t2 = B & A,
         t3 = t1 & C;
  assign Y = (((~C & t1) | ~t1) & ((t1 & (C | ~C)) & (~t1 | t1))) ^ (((~C & t1) | ~t1) & C);
  assign X = (Y | (t2 | t3)) & ((t2 | ~Y) | t3);
endmodule

