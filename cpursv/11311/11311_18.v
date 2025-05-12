
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((((((C & A) | ~(C & A)) & ~(C & A)) | (((C & A) | ~(C & A)) & ~(B & D))) & (((B & D) | ~(B & D)) & (((C & A) | ~(C & A)) & (B & D)))) ^ (((((C & A) | ~(C & A)) & ~(C & A)) | (((C & A) | ~(C & A)) & ~(B & D))) & (((B & D) | ~(B & D)) & (((C & A) | ~(C & A)) & (C & A))))) == 1) X = 1;
        else if ((((~!(B & D) | !(B & D)) & (((C & (B | ~C)) & ~C) & (~C & ((((C & D) & (B | ~C)) & ~C) | B)))) ^ ((~!(B & D) | !(B & D)) & !(B & D))) == 1) X = 1;
        else X = 0;
        if (!(A & ~C) == 1) Y = 1;
        else if (((C & ((~B | D) & ((A & (~B | D)) & D))) ^ (C & ((~B | D) & (B & D)))) == 1) Y = 1;
        else if ((D & ((~B | D) & (A | ~B))) == 1) Y = 1;
        else Y = 0;
      end
endmodule

