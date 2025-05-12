
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((A & ~B) | ((B | A) & ~A)) ^ Cin;
  assign Cout = (A & (Cin | B)) | (B & Cin);
endmodule

