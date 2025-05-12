
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((B & D) ^ (C & A)) == 1) X = 1;
        else if (((((~((C & (D | ((B & ~C) & C))) & ~C) | (~!(B & D) & C)) & (((B | (D & ~C)) & ~C) | ~((C & (D | ((B & ~C) & C))) & ~C))) & ((~C & C) | ((!(B & D) & ~((C & (D | ((B & ~C) & C))) & ~C)) | ((B & ~C) & C)))) & ((!(B & D) & ~((C & (D | ((B & ~C) & C))) & ~C)) | (D | (B & ~C)))) == 1) X = 1;
        else X = 0;
        if (!(A & ~C) == 1) Y = 1;
        else if (((C & ((~A | A) & ((~B | D) & (B & D)))) ^ (C & ((~A | A) & ((~B | D) & ((A & (~B | D)) & D))))) == 1) Y = 1;
        else if ((((A & (~B | D)) & D) | (D & ~B)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

