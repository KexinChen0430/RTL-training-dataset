
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((Cin & ~(((~A | ((B | A) & ~B)) & A) | (B & ~A))) | ((~Cin & (~B & ((~A | ((B | A) & ~B)) & A))) | (~Cin & ~A))) & ((Cin & ~(((~A | ((B | A) & ~B)) & A) | (B & ~A))) | (B | A));
  assign Cout = (A | (Cin & B)) & ((A & (B | Cin)) | Cin);
endmodule

