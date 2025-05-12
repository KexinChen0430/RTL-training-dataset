
module techlib_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [WIDTH-1:0] A,B,C;
  output [WIDTH-1:0] X,Y;
  wire [WIDTH-1:0] t1,t2,t3;

  assign t1 = ((B | ~B) & ((~A | (A | B)) & B)) ^ (A & (B | ~B)),
         t2 = A & B,
         t3 = t1 & C;
  assign Y = C ^ t1;
  assign X = (~Y & Y) | (t3 | t2);
endmodule

