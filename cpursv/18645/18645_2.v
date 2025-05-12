
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = (~((B & ~A) | (A & ~B)) & Cin) | (((((A & ~B) & ~Cin) | ((~Cin & (B & ~A)) | Cin)) & (((((~((B & ~A) | (A & ~B)) & Cin) | ~Cin) & (A & ~Cin)) & ((~((B & ~A) | (A & ~B)) & Cin) | ~Cin)) & (((A & ~B) & ~Cin) | ((~Cin & (B & ~A)) | Cin)))) ^ ((((A & ~B) & ~Cin) | ((~Cin & (B & ~A)) | Cin)) & ((((~Cin & B) & ((~((B & ~A) | (A & ~B)) & Cin) | ~Cin)) & ((~((B & ~A) | (A & ~B)) & Cin) | ~Cin)) & (((A & ~B) & ~Cin) | ((~Cin & (B & ~A)) | Cin)))));
  assign Cout = (Cin | (B & A)) & (A | (B & Cin));
endmodule

