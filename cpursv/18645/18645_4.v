
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((((B & ~A) & ~Cin) | ~(A ^ B)) | ((A & ~Cin) & ~B)) & ((B & ~A) | ((A & ~B) | (Cin & ~(A ^ B))));
  assign Cout = ((B & A) | Cin) & (A | (B & Cin));
endmodule

