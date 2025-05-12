
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = (((((~Cin & B) & ~(~Cin & A)) | ((A & (~Cin & ~(~Cin & B))) | Cin)) & (((((~Cin | ~(((B & ~A) | A) & (~A | (~B & A)))) & (((~Cin & A) & (~Cin | ~(((B & ~A) | A) & (~A | (~B & A))))) & (~Cin | ~(((B & ~A) | A) & (~A | (~B & A)))))) & (~Cin | ~(((B & ~A) | A) & (~A | (~B & A))))) & (~Cin | ~(((B & ~A) | A) & (~A | (~B & A))))) & (~Cin | ~(((B & ~A) | A) & (~A | (~B & A)))))) ^ ((((~Cin & B) & ~(~Cin & A)) | ((A & (~Cin & ~(~Cin & B))) | Cin)) & (((((((~Cin | ~(((B & ~A) | A) & (~A | (~B & A)))) & (~Cin & B)) & (~Cin | ~(((B & ~A) | A) & (~A | (~B & A))))) & (~Cin | ~(((B & ~A) | A) & (~A | (~B & A))))) & (~Cin | ~(((B & ~A) | A) & (~A | (~B & A))))) & (~Cin | ~(((B & ~A) | A) & (~A | (~B & A))))) & (~Cin | ~(((B & ~A) | A) & (~A | (~B & A))))))) | (~(((B & ~A) | A) & (~A | (~B & A))) & Cin);
  assign Cout = (Cin | A) & ((B | Cin) & (B | A));
endmodule

