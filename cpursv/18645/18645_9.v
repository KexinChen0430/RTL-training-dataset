
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = Cin ^ ((((Cin & A) | B) | A) & ((B & ~A) | ~B));
  assign Cout = (((Cin & A) | B) & Cin) | (A & (Cin | B));
endmodule

