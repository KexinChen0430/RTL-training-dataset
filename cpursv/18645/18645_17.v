
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((((A | (B | (A & Cin))) & ~B) & A) & ~Cin) | ((Cin & ~(B ^ A)) | ((B & ~Cin) & ~A));
  assign Cout = (((Cin | B) & (A | Cin)) & B) | (A & (Cin | B));
endmodule

