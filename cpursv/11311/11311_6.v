
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!(((A & C) & ((((~(D & B) & C) | ~(A & C)) & ~(A & C)) | (((~(D & B) & C) | ~(A & C)) & A))) | (B & (D & ~(A & C)))) == 1) X = 1;
        else if ((((~!(D & B) | ~((~C & (B & C)) | (C & (~C & D)))) & (((~C | B) | ~((~C & (B & C)) | (C & (~C & D)))) & (((~C | B) | ~((~C & (B & C)) | (C & (~C & D)))) & !(D & B)))) ^ ((~!(D & B) | ~((~C & (B & C)) | (C & (~C & D)))) & (((~C | B) | ~((~C & (B & C)) | (C & (~C & D)))) & (((~C | B) | ~((~C & (B & C)) | (C & (~C & D)))) & ((~C & (B & C)) | (C & (~C & D))))))) == 1) X = 1;
        else X = 0;
        if (!(A & ~C) == 1) Y = 1;
        else if (((~(C & ((~A | A) & (D & B))) & (C & ((~A | A) & (D & A)))) | ((C & ((~A | A) & (D & B))) & ~(C & ((~A | A) & (D & A))))) == 1) Y = 1;
        else if ((D & (A | ~B)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

