
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((((~(A & C) & D) & B) | ((B & D) & ((((B | (~(B & D) & C)) & (A | B)) & A) & (~(B & D) & C)))) | ((((B | (~(B & D) & C)) & (A | B)) & A) & (~(B & D) & C))) == 1) X = 1;
        else if ((((~!(B & D) | !(B & D)) & ((~(((~C & B) | D) & (~C & C)) | (((~C & B) | D) & (~C & C))) & ((~!(B & D) | !(B & D)) & ((~!(B & D) | !(B & D)) & !(B & D))))) ^ ((~!(B & D) | !(B & D)) & ((~(((~C & B) | D) & (~C & C)) | (((~C & B) | D) & (~C & C))) & ((~!(B & D) | !(B & D)) & ((~!(B & D) | !(B & D)) & (((~C & B) | D) & (~C & C))))))) == 1) X = 1;
        else X = 0;
        if (!(~C & A) == 1) Y = 1;
        else if ((((~B | D) & (D & (C & (((B | ~C) | ~B) & A)))) ^ ((~B | D) & (D & (C & (((B | ~C) | ~B) & B))))) == 1) Y = 1;
        else if ((((~B | A) & (~B | D)) & D) == 1) Y = 1;
        else Y = 0;
      end
endmodule

