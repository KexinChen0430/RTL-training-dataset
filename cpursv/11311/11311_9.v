
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((((~(C & A) | (A & ~(B & D))) & ~(C & A)) | ((~(C & A) | (A & ~(B & D))) & C)) & ((B & D) | (C & A))) == 1) X = 1;
        else if ((((!(B & D) & (~!(B & D) & ((~C & (B | D)) & C))) | ((((C | ~((~C & (B | D)) & C)) & (((~C & ~!(B & D)) | ~((~C & (B | D)) & C)) & ((D | ~((~C & (B | D)) & C)) | B))) & ~((~C & (B | D)) & C)) & !(B & D))) ^ ((((C | ~((~C & (B | D)) & C)) & (((~C & ~!(B & D)) | ~((~C & (B | D)) & C)) & ((D | ~((~C & (B | D)) & C)) | B))) & (C & ~C)) & (((~C & (B | D)) & D) | B))) == 1) X = 1;
        else X = 0;
        if (!(~C & A) == 1) Y = 1;
        else if (((((~(B & D) & D) & A) & C) | (C & ((B & D) & ~(A & D)))) == 1) Y = 1;
        else if ((D & (~B | A)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

