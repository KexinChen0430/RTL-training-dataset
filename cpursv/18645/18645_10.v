
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((((~Cin | ((Cin | A) & (Cin | B))) & (Cin | (((A | B) & ~A) | (((A | B) & ~B) & A)))) & ((~(((A | B) & ~A) | (((A | B) & ~B) & A)) | ~Cin) & ((((~(((A | B) & ~A) | (((A | B) & ~B) & A)) | ~Cin) & (B & ~Cin)) & (~(((A | B) & ~A) | (((A | B) & ~B) & A)) | ~Cin)) & (~(((A | B) & ~A) | (((A | B) & ~B) & A)) | ~Cin)))) ^ (((~Cin | ((Cin | A) & (Cin | B))) & (Cin | (((A | B) & ~A) | (((A | B) & ~B) & A)))) & (((((~(((A | B) & ~A) | (((A | B) & ~B) & A)) | ~Cin) & (A & ((A | B) & ~Cin))) & (~(((A | B) & ~A) | (((A | B) & ~B) & A)) | ~Cin)) & (~(((A | B) & ~A) | (((A | B) & ~B) & A)) | ~Cin)) & (~(((A | B) & ~A) | (((A | B) & ~B) & A)) | ~Cin)))) | (Cin & ~(((A | B) & ~A) | (((A | B) & ~B) & A)));
  assign Cout = ((Cin | A) & (Cin | B)) & (A | B);
endmodule

