
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((((~Cin & (B & ~A)) | (Cin | ((A & ~B) & ~Cin))) & (((~((B & ~A) | (A & (~B | ~A))) | ((~(((A | (B | (A & Cin))) & ~Cin) & A) & ~Cin) & B)) | ((((A | (B | (A & Cin))) & ~Cin) & A) & ~(B & ~Cin))) & (((~Cin & (B & ~A)) | (Cin | ((A & ~B) & ~Cin))) & ((((~((B & ~A) | (A & (~B | ~A))) | ((~(((A | (B | (A & Cin))) & ~Cin) & A) & ~Cin) & B)) | ((((A | (B | (A & Cin))) & ~Cin) & A) & ~(B & ~Cin))) & A) & ~Cin)))) ^ (((~Cin & (B & ~A)) | (Cin | ((A & ~B) & ~Cin))) & ((((~Cin & (B & ~A)) | (Cin | ((A & ~B) & ~Cin))) & (~Cin & (((~((B & ~A) | (A & (~B | ~A))) | ((~(((A | (B | (A & Cin))) & ~Cin) & A) & ~Cin) & B)) | ((((A | (B | (A & Cin))) & ~Cin) & A) & ~(B & ~Cin))) & B))) & ((~((B & ~A) | (A & (~B | ~A))) | ((~(((A | (B | (A & Cin))) & ~Cin) & A) & ~Cin) & B)) | ((((A | (B | (A & Cin))) & ~Cin) & A) & ~(B & ~Cin)))))) | (~((B & ~A) | (A & (~B | ~A))) & Cin);
  assign Cout = ((Cin & B) | A) & (B | (A & Cin));
endmodule

