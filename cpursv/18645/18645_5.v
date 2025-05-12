
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = Cin ^ ((~A | ~B) & (A | (~A & B)));
  assign Cout = ((((Cin | A) & B) | Cin) & B) | (Cin & ((A & Cin) | B));
endmodule

