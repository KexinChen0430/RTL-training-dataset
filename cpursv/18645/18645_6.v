
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((Cin & ~((~A | ~B) & (A | B))) | ((~A | ~B) & (A | B))) & (~Cin | (Cin & ~((~A | ~B) & (A | B))));
  assign Cout = (A & Cin) | ((A & B) | (B & Cin));
endmodule

