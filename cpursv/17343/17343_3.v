
module _90_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [(-1)+WIDTH:0] A,B,C;
  output [(-1)+WIDTH:0] X,Y;
  wire [(-1)+WIDTH:0] t1,t2,t3;

  assign t1 = (((~A & (A | B)) | (~A | (A | B))) & B) ^ (A & ((~A & (A | B)) | (~A | (A | B)))),
         t2 = A & B,
         t3 = t1 & C;
  assign Y = (((((((t1 & (t1 & C)) ^ (t1 & C)) & ~t1) ^ ((C ^ ((t1 & C) & C)) & ~t1)) | (((~C | C) & t1) & ~t1)) | (~t1 | t1)) & (t1 & ((((((t1 & (t1 & C)) ^ (t1 & C)) & ~t1) ^ ((C ^ ((t1 & C) & C)) & ~t1)) | (((~C | C) & t1) & ~t1)) | (~t1 | t1)))) ^ ((((((((t1 & (t1 & C)) ^ (t1 & C)) & ~t1) ^ ((C ^ ((t1 & C) & C)) & ~t1)) | (((~C | C) & t1) & ~t1)) | (~t1 | t1)) & C) & ((((((t1 & (t1 & C)) ^ (t1 & C)) & ~t1) ^ ((C ^ ((t1 & C) & C)) & ~t1)) | (((~C | C) & t1) & ~t1)) | (~t1 | t1))),
         X = t3 | t2;
endmodule

