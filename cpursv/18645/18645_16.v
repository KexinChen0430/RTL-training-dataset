
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((A & ~B) | (B & ~A)) ^ Cin;
  assign Cout = (B & A) | ((A & Cin) | (B & Cin));
endmodule

