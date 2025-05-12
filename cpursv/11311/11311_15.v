
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((((C & A) | ~(C & A)) & ((~(B & D) | ~(C & A)) & (((D | ~B) | ~(B & D)) & (B & D)))) ^ (((C & A) | ~(C & A)) & ((~(B & D) | ~(C & A)) & (((D | ~B) | ~(B & D)) & (C & A))))) == 1) X = 1;
        else if (((((~(((B & ~C) | (~C & (C & D))) & C) | (~C & C)) & (~(((B & ~C) | (~C & (C & D))) & C) | (D | B))) & (((~(((B & ~C) | (~C & (C & D))) & C) | (~C & C)) & (~(((B & ~C) | (~C & (C & D))) & C) | (D | B))) & ((~!(B & D) | !(B & D)) & (((B & ~C) | (~C & (C & D))) & C)))) ^ (((~(((B & ~C) | (~C & (C & D))) & C) | (~C & C)) & (~(((B & ~C) | (~C & (C & D))) & C) | (D | B))) & (((~(((B & ~C) | (~C & (C & D))) & C) | (~C & C)) & (~(((B & ~C) | (~C & (C & D))) & C) | (D | B))) & ((~!(B & D) | !(B & D)) & !(B & D))))) == 1) X = 1;
        else X = 0;
        if (!(A & ~C) == 1) Y = 1;
        else if (((~B & (A & (C & D))) | (((~A & B) | (B & ~B)) & (C & D))) == 1) Y = 1;
        else if ((D & (~B | A)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

