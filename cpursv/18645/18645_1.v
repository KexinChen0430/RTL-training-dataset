
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((A | B) | (Cin & ~(A ^ B))) & (((~A & ~Cin) | (~Cin & (A & ~B))) | (Cin & ~(A ^ B)));
  assign Cout = (((Cin & B) | (A & Cin)) | A) & (Cin | (B & A));
endmodule

