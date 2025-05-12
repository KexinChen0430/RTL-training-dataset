
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = (Cin & ~(B ^ A)) | (((((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A))) & (((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A))) & ((((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A))) & ((((~Cin & A) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A)))) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A)))) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A))))) & ((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A)))))) & ~(((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A))) & (((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A))) & ((((((B & ~Cin) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A)))) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A)))) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A)))) & ((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A)))) & ((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A))))))) | (~(((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A))) & (((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A))) & ((((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A))) & ((((~Cin & A) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A)))) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A)))) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A))))) & ((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A)))))) & (((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A))) & (((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A))) & ((((((B & ~Cin) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A)))) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A)))) & ((Cin | (~A & (B & ~Cin))) | (~B & (~Cin & A)))) & ((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A)))) & ((~B & (~Cin & A)) | ((~A & (B & ~Cin)) | ~(B ^ A))))))));
  assign Cout = ((B & A) | (Cin & A)) | (B & ((A | Cin) & (A | B)));
endmodule

