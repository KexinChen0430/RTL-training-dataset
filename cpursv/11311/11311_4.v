
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!(((~(A & C) & B) & D) | ((((B | C) & ((A & ~(B & D)) | B)) & (A & ~(B & D))) & C)) == 1) X = 1;
        else if ((((~((~C & C) & ((~C & (B & C)) | D)) | (D | ~C)) & ((~!(B & D) | !(B & D)) & (((~C & C) & ((~C & (B & C)) | D)) & (~!(B & D) | (~((~C & C) & ((~C & (B & C)) | D)) & !(B & D)))))) ^ ((~((~C & C) & ((~C & (B & C)) | D)) | (D | ~C)) & ((~!(B & D) | !(B & D)) & ((~!(B & D) | (~((~C & C) & ((~C & (B & C)) | D)) & !(B & D))) & !(B & D))))) == 1) X = 1;
        else X = 0;
        if (!(A & ~C) == 1) Y = 1;
        else if ((((~A | A) & ((C & D) & ((~A | A) & ((B & (~A | A)) & (~B | ~A))))) ^ ((~A | A) & ((C & D) & ((~A | A) & (A & (~B | ~A)))))) == 1) Y = 1;
        else if (((~B | (D & A)) & D) == 1) Y = 1;
        else Y = 0;
      end
endmodule

