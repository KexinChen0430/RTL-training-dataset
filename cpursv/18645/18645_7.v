
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = (~((((~A & B) | ~B) & A) | (~A & B)) & Cin) | (((((~Cin & (~A & B)) | Cin) | ((~B & A) & ~Cin)) & ((((~Cin & (~A & B)) | Cin) | ((~B & A) & ~Cin)) & (((~((((~A & B) | ~B) & A) | (~A & B)) | (A & (~Cin & ~(B & ~Cin)))) | ((~(A & (~Cin & (B | A))) & ~Cin) & B)) & ((((~((((~A & B) | ~B) & A) | (~A & B)) | (A & (~Cin & ~(B & ~Cin)))) | ((~(A & (~Cin & (B | A))) & ~Cin) & B)) & (((~((((~A & B) | ~B) & A) | (~A & B)) | (A & (~Cin & ~(B & ~Cin)))) | ((~(A & (~Cin & (B | A))) & ~Cin) & B)) & ((((~Cin & (~A & B)) | Cin) | ((~B & A) & ~Cin)) & ((A & (~Cin & (B | A))) & ((~((((~A & B) | ~B) & A) | (~A & B)) | (A & (~Cin & ~(B & ~Cin)))) | ((~(A & (~Cin & (B | A))) & ~Cin) & B)))))) & ((~((((~A & B) | ~B) & A) | (~A & B)) | (A & (~Cin & ~(B & ~Cin)))) | ((~(A & (~Cin & (B | A))) & ~Cin) & B)))))) ^ ((((~Cin & (~A & B)) | Cin) | ((~B & A) & ~Cin)) & ((((~Cin & (~A & B)) | Cin) | ((~B & A) & ~Cin)) & (((~((((~A & B) | ~B) & A) | (~A & B)) | (A & (~Cin & ~(B & ~Cin)))) | ((~(A & (~Cin & (B | A))) & ~Cin) & B)) & ((((~((((~A & B) | ~B) & A) | (~A & B)) | (A & (~Cin & ~(B & ~Cin)))) | ((~(A & (~Cin & (B | A))) & ~Cin) & B)) & (((~((((~A & B) | ~B) & A) | (~A & B)) | (A & (~Cin & ~(B & ~Cin)))) | ((~(A & (~Cin & (B | A))) & ~Cin) & B)) & ((((~Cin & (~A & B)) | Cin) | ((~B & A) & ~Cin)) & ((B & ~Cin) & ((~((((~A & B) | ~B) & A) | (~A & B)) | (A & (~Cin & ~(B & ~Cin)))) | ((~(A & (~Cin & (B | A))) & ~Cin) & B)))))) & ((~((((~A & B) | ~B) & A) | (~A & B)) | (A & (~Cin & ~(B & ~Cin)))) | ((~(A & (~Cin & (B | A))) & ~Cin) & B)))))));
  assign Cout = ((B | A) & (B | Cin)) & ((B | Cin) & (Cin | A));
endmodule

