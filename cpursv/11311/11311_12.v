
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((((~(C & A) & B) | (C & A)) & ((C & A) | D)) & ((((((~(C & A) & B) | C) & ((A & ~(D & B)) | (~(C & A) & B))) & ~(D & B)) & (C & A)) | ~(C & A))) == 1) X = 1;
        else if (((((((((B | D) & (D | ~C)) | ~((~C & C) & ((B | D) & (B | ~C)))) & ((~C & C) | ~((~C & C) & ((B | D) & (B | ~C))))) & ~((~C & C) & ((B | D) & (B | ~C)))) | (((((B | D) & (D | ~C)) | ~((~C & C) & ((B | D) & (B | ~C)))) & ((~C & C) | ~((~C & C) & ((B | D) & (B | ~C))))) & ~!(D & B))) & (((((B | D) & (D | ~C)) | ~((~C & C) & ((B | D) & (B | ~C)))) & ((~C & C) | ~((~C & C) & ((B | D) & (B | ~C))))) & !(D & B))) ^ (((((((B | D) & (D | ~C)) | ~((~C & C) & ((B | D) & (B | ~C)))) & ((~C & C) | ~((~C & C) & ((B | D) & (B | ~C))))) & ~((~C & C) & ((B | D) & (B | ~C)))) | (((((B | D) & (D | ~C)) | ~((~C & C) & ((B | D) & (B | ~C)))) & ((~C & C) | ~((~C & C) & ((B | D) & (B | ~C))))) & ~!(D & B))) & (((((B | D) & (D | ~C)) | ~((~C & C) & ((B | D) & (B | ~C)))) & ((~C & C) | ~((~C & C) & ((B | D) & (B | ~C))))) & ((~C & C) & ((B | D) & (B | ~C)))))) == 1) X = 1;
        else X = 0;
        if (!(A & ~C) == 1) Y = 1;
        else if ((((~B | D) & (C & ((A | ~A) & ((~B | D) & (D & A))))) ^ ((~B | D) & (C & ((A | ~A) & ((~B | D) & (D & B)))))) == 1) Y = 1;
        else if (((D & A) | (D & ~B)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

