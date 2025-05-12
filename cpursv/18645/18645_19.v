
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = (((~B | ~A) & (A | B)) | (Cin & ~((~B | ~A) & (A | B)))) & (((~(B & ~Cin) & ~Cin) & A) | (~((~B | ~A) & (A | B)) | (~(A & ~Cin) & (B & ~Cin))));
  assign Cout = (((A & B) | Cin) & B) | ((Cin & B) | (Cin & A));
endmodule

