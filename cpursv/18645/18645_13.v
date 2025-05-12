
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((~(B ^ A) & Cin) | ((B & ~(((B | A) & ~Cin) & A)) & ~Cin)) | ((~(~Cin & B) & ~Cin) & A);
  assign Cout = (Cin & ((Cin | A) & (B | A))) | (A & (B | (Cin & ((Cin | A) & (B | A)))));
endmodule

