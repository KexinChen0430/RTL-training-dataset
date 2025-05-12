
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = (((A | B) | ~((A | B) & (((A | B) & ~B) | ~A))) & (~((A | B) & (((A | B) & ~B) | ~A)) | ((~Cin & ~A) | ((A & ~B) & ~Cin)))) & ((Cin & ~((A | B) & (((A | B) & ~B) | ~A))) | ((A | B) & (((A | B) & ~B) | ~A)));
  assign Cout = (A & Cin) | (((A | Cin) & (A | B)) & B);
endmodule

