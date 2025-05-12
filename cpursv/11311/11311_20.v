
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((((A & C) | (D & ~(A & C))) & ((A & C) | B)) & (~(A & C) | ~(B & D))) == 1) X = 1;
        else if ((((~((C & ~C) & ((B | D) & (~C | B))) | ~!(B & D)) & ((((((B | D) & (~C | B)) | ~((C & ~C) & ((B | D) & (~C | B)))) & (~C | ~((C & ~C) & ((B | D) & (~C | B))))) & (~((C & ~C) & ((B | D) & (~C | B))) | C)) & ((~((C & ~C) & ((B | D) & (~C | B))) | ~!(B & D)) & ((!(B & D) | ~!(B & D)) & ((C & ~C) & ((B | D) & (~C | B))))))) ^ ((~((C & ~C) & ((B | D) & (~C | B))) | ~!(B & D)) & ((((((B | D) & (~C | B)) | ~((C & ~C) & ((B | D) & (~C | B)))) & (~C | ~((C & ~C) & ((B | D) & (~C | B))))) & (~((C & ~C) & ((B | D) & (~C | B))) | C)) & ((~((C & ~C) & ((B | D) & (~C | B))) | ~!(B & D)) & ((!(B & D) | ~!(B & D)) & !(B & D)))))) == 1) X = 1;
        else X = 0;
        if (!(A & ~C) == 1) Y = 1;
        else if ((((~B & (A & (~A | ~B))) & (C & D)) | (((~A & C) & B) & D)) == 1) Y = 1;
        else if (((D & A) | (D & ~B)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

