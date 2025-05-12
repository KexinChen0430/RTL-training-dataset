
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!(((~(D & B) | ~(A & C)) & ((~(A & C) | (A & C)) & ((~(A & C) | (A & C)) & ((~(D & B) | (D & B)) & (D & B))))) ^ ((~(D & B) | ~(A & C)) & ((~(A & C) | (A & C)) & ((~(A & C) | (A & C)) & ((~(D & B) | (D & B)) & (A & C)))))) == 1) X = 1;
        else if ((((((((B | ~C) | ~(((D | B) & ~C) & C)) & ~(((D | B) & ~C) & C)) | (((B | ~C) | ~(((D | B) & ~C) & C)) & ~!(D & B))) & !(D & B)) & ~(((D | B) & ~C) & C)) | ((((~!(D & B) & ~C) & C) & (~C | D)) & (D | B))) == 1) X = 1;
        else X = 0;
        if (!(A & ~C) == 1) Y = 1;
        else if (((D & ((~B | D) & (B & C))) ^ (D & ((~B | D) & (A & C)))) == 1) Y = 1;
        else if (((A | (D & ~B)) & D) == 1) Y = 1;
        else Y = 0;
      end
endmodule

