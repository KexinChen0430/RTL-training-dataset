
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((B & D) ^ (A & C)) == 1) X = 1;
        else if (((((~(~C & ((C & D) | (C & (B & C)))) | (((~C & D) | C) & ((D | (B | (~B & D))) & ~C))) & (C | ~(~C & ((C & D) | (C & (B & C)))))) & (((~(~C & ((C & D) | (C & (B & C)))) | (((~C & D) | C) & ((D | (B | (~B & D))) & ~C))) & (C | ~(~C & ((C & D) | (C & (B & C)))))) & !(B & D))) ^ (((~(~C & ((C & D) | (C & (B & C)))) | (((~C & D) | C) & ((D | (B | (~B & D))) & ~C))) & (C | ~(~C & ((C & D) | (C & (B & C)))))) & (((~(~C & ((C & D) | (C & (B & C)))) | (((~C & D) | C) & ((D | (B | (~B & D))) & ~C))) & (C | ~(~C & ((C & D) | (C & (B & C)))))) & (~C & ((C & D) | (C & (B & C))))))) == 1) X = 1;
        else X = 0;
        if (!(~C & A) == 1) Y = 1;
        else if (((((~B | D) & ((C & D) & ((~B | (~C | B)) & B))) & ~((~B | D) & ((C & D) & ((~B | (~C | B)) & A)))) | (~((~B | D) & ((C & D) & ((~B | (~C | B)) & B))) & ((~B | D) & ((C & D) & ((~B | (~C | B)) & A))))) == 1) Y = 1;
        else if ((D & (~B | A)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

