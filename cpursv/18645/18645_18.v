
module add1(input  A,
            input  B,
            input  Cin,
            output Q,
            output Cout);

  assign Q = ((((~(A & ~Cin) & (~Cin & B)) | (Cin | (~(~Cin & B) & (A & ~Cin)))) & ((((~(A & ~Cin) & (~Cin & B)) | (Cin | (~(~Cin & B) & (A & ~Cin)))) & (((~Cin | (~((A & (~B & (B | A))) | (~A & (B | A))) & Cin)) & (((~(A & ~Cin) & (~Cin & B)) | (Cin | (~(~Cin & B) & (A & ~Cin)))) & (A & ~Cin))) & ((~(A & ~Cin) & (~Cin & B)) | (Cin | (~(~Cin & B) & (A & ~Cin)))))) & ((~(A & ~Cin) & (~Cin & B)) | (Cin | (~(~Cin & B) & (A & ~Cin)))))) ^ (((~(A & ~Cin) & (~Cin & B)) | (Cin | (~(~Cin & B) & (A & ~Cin)))) & ((((~(A & ~Cin) & (~Cin & B)) | (Cin | (~(~Cin & B) & (A & ~Cin)))) & ((((~Cin & B) & ((~(A & ~Cin) & (~Cin & B)) | (Cin | (~(~Cin & B) & (A & ~Cin))))) & (~Cin | (~((A & (~B & (B | A))) | (~A & (B | A))) & Cin))) & ((~(A & ~Cin) & (~Cin & B)) | (Cin | (~(~Cin & B) & (A & ~Cin)))))) & ((~(A & ~Cin) & (~Cin & B)) | (Cin | (~(~Cin & B) & (A & ~Cin))))))) | (~((A & (~B & (B | A))) | (~A & (B | A))) & Cin);
  assign Cout = ((A & Cin) | (A & B)) | (B & Cin);
endmodule

