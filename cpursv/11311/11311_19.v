
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((((D | ~(B & D)) & (~(B & D) | (B & ~(A & C)))) & (((D | ~(B & D)) & (~(B & D) | (B & ~(A & C)))) & (((D | ~(B & D)) & (~(B & D) | (B & ~(A & C)))) & (((D | ~(B & D)) & (~(B & D) | (B & ~(A & C)))) & (A & C))))) ^ (((D | ~(B & D)) & (~(B & D) | (B & ~(A & C)))) & (((D | ~(B & D)) & (~(B & D) | (B & ~(A & C)))) & (((D | ~(B & D)) & (~(B & D) | (B & ~(A & C)))) & ((D & (B & ~(A & C))) | ((B & D) & ~(B & D))))))) == 1) X = 1;
        else if ((((((C & ~!(B & D)) & ((~C & B) | ((C & ~C) & D))) | ~(C & (~C & ((~C | B) & (D | B))))) & (((~C | B) | ~(C & (~C & ((~C | B) & (D | B))))) & (((~C | B) | ~(C & (~C & ((~C | B) & (D | B))))) & (C & (~C & ((~C | B) & (D | B))))))) ^ ((((C & ~!(B & D)) & ((~C & B) | ((C & ~C) & D))) | ~(C & (~C & ((~C | B) & (D | B))))) & (((~C | B) | ~(C & (~C & ((~C | B) & (D | B))))) & (((~C | B) | ~(C & (~C & ((~C | B) & (D | B))))) & !(B & D))))) == 1) X = 1;
        else X = 0;
        if (!(A & ~C) == 1) Y = 1;
        else if (((C & ((~A | A) & (B & D))) ^ (C & ((~A | A) & ((D & (~B | A)) & A)))) == 1) Y = 1;
        else if ((D & (~B | A)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

