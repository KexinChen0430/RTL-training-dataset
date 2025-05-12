
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!(((~(B & D) | (B & D)) & ((~(C & A) | (C & A)) & ((~(B & D) | (B & D)) & (C & A)))) ^ ((~(B & D) | (B & D)) & ((~(C & A) | (C & A)) & ((~(B & D) | (B & D)) & (B & D))))) == 1) X = 1;
        else if ((((((B | (~C & D)) & (C & ~C)) | ~((B | (~C & D)) & (C & ~C))) & ((~!(B & D) | !(B & D)) & ((!(B & D) & ~((B | (~C & D)) & (C & ~C))) | (!(B & D) & ~!(B & D))))) ^ ((((B | (~C & D)) & (C & ~C)) | ~((B | (~C & D)) & (C & ~C))) & ((~!(B & D) | !(B & D)) & ((((~((B | (~C & D)) & (C & ~C)) | ((~!(B & D) & C) & (B | (~C & D)))) & (~C | ~((B | (~C & D)) & (C & ~C)))) & (C & ~C)) & (D | B))))) == 1) X = 1;
        else X = 0;
        if (!(~C & A) == 1) Y = 1;
        else if ((((~B | D) & (C & ((~A | A) & (B & D)))) ^ ((~B | D) & (C & ((~A | A) & (A & D))))) == 1) Y = 1;
        else if (((D & ~B) | (A & D)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

