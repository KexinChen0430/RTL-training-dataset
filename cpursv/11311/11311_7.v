
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((A & C) ^ ((B & (~B | D)) & D)) == 1) X = 1;
        else if ((((((((C & (~B | D)) & D) & ~C) | (C & (B & ~C))) | ~((((C & (~B | D)) & D) & ~C) | (C & (B & ~C)))) & ((((((((C & (~B | D)) & D) & ~C) | (C & (B & ~C))) | ~((((C & (~B | D)) & D) & ~C) | (C & (B & ~C)))) & ~!((B & (~B | D)) & D)) | ((((((C & (~B | D)) & D) & ~C) | (C & (B & ~C))) | ~((((C & (~B | D)) & D) & ~C) | (C & (B & ~C)))) & ~((((C & (~B | D)) & D) & ~C) | (C & (B & ~C))))) & ((~!((B & (~B | D)) & D) | !((B & (~B | D)) & D)) & ((~!((B & (~B | D)) & D) | !((B & (~B | D)) & D)) & !((B & (~B | D)) & D))))) ^ ((((((C & (~B | D)) & D) & ~C) | (C & (B & ~C))) | ~((((C & (~B | D)) & D) & ~C) | (C & (B & ~C)))) & ((((((((C & (~B | D)) & D) & ~C) | (C & (B & ~C))) | ~((((C & (~B | D)) & D) & ~C) | (C & (B & ~C)))) & ~!((B & (~B | D)) & D)) | ((((((C & (~B | D)) & D) & ~C) | (C & (B & ~C))) | ~((((C & (~B | D)) & D) & ~C) | (C & (B & ~C)))) & ~((((C & (~B | D)) & D) & ~C) | (C & (B & ~C))))) & ((~!((B & (~B | D)) & D) | !((B & (~B | D)) & D)) & ((~!((B & (~B | D)) & D) | !((B & (~B | D)) & D)) & ((((C & (~B | D)) & D) & ~C) | (C & (B & ~C)))))))) == 1) X = 1;
        else X = 0;
        if (!(~C & A) == 1) Y = 1;
        else if (((C & ((~B | D) & ((~B | D) & ((~B | D) & ((B & (~B | D)) & D))))) ^ (C & ((~B | D) & ((~B | D) & ((~B | D) & (A & D)))))) == 1) Y = 1;
        else if (((D & ~B) | (A & D)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

