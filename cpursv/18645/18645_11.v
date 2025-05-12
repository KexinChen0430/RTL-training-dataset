
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((B | (~B & ((~B | ~A) & A))) & (~B | ~A)) ^ Cin;
  assign Cout = (((B | Cin) & A) | Cin) & (B | (A & Cin));
endmodule

